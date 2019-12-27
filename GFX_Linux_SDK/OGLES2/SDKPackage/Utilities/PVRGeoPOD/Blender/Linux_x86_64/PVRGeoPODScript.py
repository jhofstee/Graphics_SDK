import sys
import bpy
import os
import math
import platform

from bpy.props import CollectionProperty, StringProperty, BoolProperty
from bpy_extras.io_utils import ExportHelper
    
import traceback

from ctypes import *
from math import *
from operator import itemgetter

bl_info = {
    "name": "PVRGeoPOD",
    "description": "This exporter exports scene data as the PowerVR POD format.",
    "author": "Imagination Technologies Ltd.",
    "version": (2, 12),
    "blender": (2, 5, 3),
    "location": "File > Export > PVRGeoPOD (.pod/.h/.cpp)",
    "tracker_url": "http://www.imgtec.com/powervr/insider/powervr-insider.asp",
    "category": "Import-Export"}
    
class PODBuilder:
    def __init__(self):
        self.materialmap = {}
        self.nodemap = {}
        self.missingnodes = []
        self.lib = 0
        self.libname = ""
        self.maxUVWChannelsSupported = 0;
        self.quality = 'PREVIEW'
        self.ExportPOD_self = None
        
        # Node types
        self.eDummy  = 0
        self.eMesh   = 1
        self.eCamera = 2
        self.eLight  = 3
        self.eBone   = 4

        # Light types
        self.ePoint       = 0
        self.eDirectional = 1
        self.eSpot        = 2 

    def print(self, type, message):
        if self.ExportPOD_self:
            self.ExportPOD_self.report(type, message)
        if self.lib:
            self.lib.print(message.encode('utf-8','replace'))
        else:
            print(message)

    def loadLibrary(self):
        # Determine which native lib that contains our C++ component of the exporter to load
        system = platform.system()
        
        if system == 'Windows':
            self.print({'INFO'}, "Determined we're running on Windows")
            self.libname = "PVRGeoPOD.dll"
        elif system == 'Linux':
            self.print({'INFO'}, "Determined we're running on Linux")
            self.libname = "libPVRGeoPOD.so"
        elif system == 'Darwin':
            self.print({'INFO'}, "Determined we're running on Mac")
            self.libname = "libPVRGeoPOD.dylib"
        else:
            self.print("Unrecognised platform: " + system)
            return False

        # Check our addon directories to find our native library
        addonPaths = bpy.utils.script_paths("addons")

        self.lib = 0

        for path in addonPaths:
            libpath = os.path.join(path, self.libname)
            if os.path.exists(libpath):
                self.print({'INFO'}, "Attempting to load library: " + libpath)
                self.lib = cdll.LoadLibrary(libpath)
                if self.lib:
                    break

        if not self.lib:
            self.print({'ERROR'}, "Failed to load " + self.libname)
            return False
 
        # Our native library should now be successfully loaded
        self.print({'INFO'}, "Success")
        
        # Note: This will clear any output dialogs that are open
        self.lib.clearData()
        self.maxUVWChannelsSupported = self.lib.getUVWNoSupported()
        self.print({'INFO'}, "Supported number of mapping channels has been set to " + str(self.maxUVWChannelsSupported))
        return True

class Vec3f(Structure):
    _fields_ = [("x",c_float),("y",c_float),("z",c_float)]
    def __init__(self,ax,ay,az):
        self.x = c_float(ax)
        self.y = c_float(ay)
        self.z = c_float(az)

class Vec4f(Structure):
    _fields_ = [("x",c_float),("y",c_float),("z",c_float), ("w",c_float)]

class Matrixf(Structure):
    _fields_ = [("f",c_float * 16)] 
    def set(self, blenderMatrix):
        for i in range(0,4):
            for j in range(0,4):
                if bpy.app.version[0] == 2 and bpy.app.version[1] < 62:
                    self.f[i*4+j] = blenderMatrix[i][j]
                else:
                    self.f[i*4+j] = blenderMatrix[j][i]
                    
class PODSceneInfo(Structure):
    _fields_ = [("startFrame",c_int),("endFrame",c_int),("frameRate",c_int),("ambient",Vec3f),
                ("pUserData",c_char_p),("nUserDataSize",c_int)]
                
    def __init__(self):
        self.pUserData = None # Fill this out to include custom data in the POD file
        self.nUserDataSize = 0
        self.ambient.xyz = c_float(0.0)
        
class PODMaterial(Structure):
    _fields_ = [("pName",c_char_p),("pTexDiffuse",c_char_p),("pTexAmbient",c_char_p),("pTexSpecularColour",c_char_p),
                ("pTexSpecularLevel",c_char_p),("pTexBump",c_char_p),("pTexEmissive",c_char_p),
                ("pTexGlossiness",c_char_p),("pTexOpacity",c_char_p),("pTexReflection",c_char_p),
                ("pTexRefraction",c_char_p),("vDiffuse",Vec3f),("vAmbient",Vec3f),("vSpecular",Vec3f),
                ("fOpacity",c_float),("fGlossiness",c_float),("fSpecularLevel",c_float),
                ("pUserData",c_char_p),("nUserDataSize",c_int)]

    def __init__(self):
        self.pName = None
        self.fOpacity = c_float(0.0)
        self.fGlossiness = c_float(0.0)
        self.fSpecularLevel = c_float(0.0)
        self.vDiffuse.x = self.vDiffuse.y = self.vDiffuse.z = c_float(0.0)
        self.vAmbient.x = self.vAmbient.y = self.vAmbient.z = c_float(0.0)
        self.vSpecular.xyz = c_float(0.0)
        self.pTexDiffuse = None
        self.pTexAmbient = None
        self.pTexSpecularColour = None
        self.pTexSpecularLevel = None
        self.pTexBump = None
        self.pTexEmissive = None
        self.pTexGlossiness = None
        self.pTexOpacity = None
        self.pTexReflection = None
        self.pTexRefraction = None

        self.pUserData = None  # Fill this out to include custom data in the POD file
        self.nUserDataSize = 0

class PODLightData(Structure): 
    _fields_ = [("eType",c_int),("pColour",Vec3f),("nTargetID",c_int),("fConstantAttenuation",c_float),("fLinearAttenuation",c_float),
    ("fQuadraticAttenuation",c_float),("fFalloffAngle",c_float),("fFalloffExponent",c_float)]
    def __init__(self):
        self.eType = 0
        self.nTargetID = -1
        self.fConstantAttenuation  = c_float(1.0)
        self.fLinearAttenuation    = c_float(0.0)
        self.fQuadraticAttenuation = c_float(0.0)
        self.fFalloffAngle		   = c_float(radians(180))
        self.fFalloffExponent	   = c_float(0.0)

class PODCameraData(Structure):
    _fields_ = [("eType",c_int),("fFOV",c_float),("fFarClip",c_float),("fNearClip",c_float),("nTargetID",c_int),
    ("pFOVAnim",POINTER(c_float)),("nFOVAnimSize",c_int)]	

    def __init__(self):
        self.eType = 0
        self.nTargetID = -1
        self.fFOV = 0.0
        self.pFOVAnim = None
        self.nFOVAnimSize = 0

class BoneWeight(Structure):
    _fields_ = [("nBone",c_int),("fWeight",c_float)]
    def __init__(self):
        self.nBone = -1
        self.fWeight = 1.0

class BonedVtx(Structure): 
    _fields_ = [("pBone",POINTER(BoneWeight)),("nBoneSize",c_int)]
    def __init__(self):
        self.pBone = None
        self.nBoneSize = 0

class Modifier(Structure):
    _fields_ = [("pVtx",POINTER(BonedVtx)),("nVtxSize",c_int)] 	
    def __init__(self):
        self.nVtxSize = 0
        self.pVtx = None
        
class TriIdx(Structure):
    _fields_ = [("i",c_int * 3)]
    def __init__(self):
        self.i[0] = -1
        self.i[1] = -1
        self.i[2] = -1

class PODFace(Structure): 
    _fields_ = [("sVtx",TriIdx),("smGrp",c_int),("i32MatID",c_int),("sNrm",TriIdx),("sVtxCol",TriIdx)]	
    def __init__(self):
        self.sVtx = TriIdx()
        self.i32MatID = -1
        self.sNrm = TriIdx()
        self.sVtxCol = TriIdx()

class PODMappingChannel(Structure):  
    _fields_ = [("pVtx",POINTER(Vec3f)),("pIdx",POINTER(TriIdx)),("nVtxSize",c_int),("nIdxSize",c_int) ]		
    def __init__(self):
        self.pVtx = None
        self.nVtxSize = 0
        self.pIdx = None
        self.nIdxSize = 0

class PODGeometryData(Structure):
    _fields_ = [("pVtx",POINTER(Vec3f)),("pNrm",POINTER(Vec3f)),("pCol",POINTER(Vec4f)),("pFace",POINTER(PODFace)),("pMap",POINTER(PODMappingChannel)),
                ("nVtxSize",c_int),("nNrmSize",c_int),("nColSize",c_int),("nFaceSize",c_int),("nMapSize",c_int)]
    def __init__(self):
        self.pVtx = None
        self.nVtxSize = 0
        self.pNrm = None
        self.nNrmSize = 0
        self.pCol = None
        self.nColSize = 0
        self.pFace = None
        self.nFaceSize = 0
        self.pMap = None
        self.nMapSize = 0

class PODNode(Structure):
    _fields_ = [("nParentID",c_int),("pName",c_char_p),("eNodeType",c_int),
                ("transformation",Matrixf),("sGeomData",PODGeometryData),("sLightData",PODLightData),("sCameraData",PODCameraData),
                ("pModData",POINTER(Modifier)),("nModDataSize",c_int),("pUserData",c_char_p),("nUserDataSize",c_int)]
                
    def __init__(self):
        self.nParentID      = -1
        self.pName          = c_char_p(b"")
        self.eNodeType      = 0
        self.transformation = Matrixf()
        self.sGeomData      = PODGeometryData()
        self.sLightData     = PODLightData()
        self.sCameraData    = PODCameraData()

        self.pModData = None
        self.nModDataSize = 0
        
        self.pUserData = None  # Fill this out to include custom data in the POD file
        self.nUserDataSize = 0
        
def GetString(obj, pvrgeopod):
    try:
        return obj.name.encode('utf-8','replace')
    except Exception as err:
        pvrgeopod.print({'ERROR'},"Failed to get string: " + str(err))
        return None
    
def AddMesh(pvrgeopod, obj, parentID):
    node = PODNode()
    node.nParentID  = parentID
    node.pName      = GetString(obj, pvrgeopod)
    node.eNodeType  = pvrgeopod.eMesh
    node.transformation.set(obj.matrix_local)

    bNeedSkinning = pvrgeopod.lib.exportSkinning()
    
    if bNeedSkinning:
        armature = obj.find_armature()
    else:
        armature = None

    if armature: # Do we have an armature?
        if obj.vertex_groups:
            vertex_groups = obj.vertex_groups
        else:
            vertex_groups = armature.vertex_groups

        if not vertex_groups:
            bNeedSkinning = False
    else: # If not then we have no need to enable skinning
        bNeedSkinning = False
        
    if not obj.type == 'MESH' or obj.modifiers: # Do we need to convert our object to a mesh? Have we got modifiers to apply to the mesh data?
        # PREVIEW Preview, Apply modifier preview settings.
        # RENDER  Render, Apply modifier render settings. 
        mesh = obj.to_mesh(bpy.context.scene, True, pvrgeopod.quality); #  Create our mesh data with all modifiers applied
    else:
        mesh = obj.data
        
    # Add the meshes materials (if needed)
    bNeedMaterials = pvrgeopod.lib.exportMaterials()
    
    materiallist = []
    
    if bNeedMaterials:
        for material in mesh.materials:
            materiallist.append(AddMaterial(pvrgeopod, material))
        if len(materiallist) == 0:
            bNeedMaterials = False
    
    # Get what we need to export
    bNeedNormals        = pvrgeopod.lib.exportNormals()
    bNeedUVWs           = pvrgeopod.lib.exportUVWs()
    bNeedVertexColours  = pvrgeopod.lib.exportVertexColours()
    
    # Calculate the number of vertices and faces
    tricnt = 0;

    # Are we being ran from an older version of blender than 2.63?
    if bpy.app.version[0] == 2 and bpy.app.version[1] < 63:
        faces = mesh.faces
        uv_textures = mesh.uv_textures
        vertex_colors = mesh.vertex_colors
    else:
        # Calculate our triangles
        mesh.calc_tessface()
        faces = mesh.tessfaces
        uv_textures = mesh.tessface_uv_textures
        vertex_colors = mesh.tessface_vertex_colors
        
    for face in faces:
        tricnt += (len(face.vertices) - 2)

    # Initialise our data structures
    node.sGeomData.nVtxSize = c_int(tricnt * 3)
    node.sGeomData.pVtx = (tricnt * 3 * Vec3f)()
    
    node.sGeomData.nFaceSize = c_int(tricnt)
    node.sGeomData.pFace = (tricnt * PODFace)()
    
    if bNeedNormals:
        node.sGeomData.pNrm = (tricnt * 3 * Vec3f)()
        node.sGeomData.nNrmSize = c_int(tricnt * 3)
    
    if bNeedUVWs:
        UVData = []
        for coords in uv_textures:
            if coords.active_render:
                UVData.append(coords.data)
        channelCnt = len(UVData)
        if channelCnt:
            if channelCnt > pvrgeopod.maxUVWChannelsSupported: # Do we have more channels than POD supports?
                channelCnt = pvrgeopod.maxUVWChannelsSupported # If so, cap our channel count
                
            node.sGeomData.nMapSize = channelCnt
            node.sGeomData.pMap = (channelCnt * PODMappingChannel)()
            for i in range(channelCnt):
                node.sGeomData.pMap[i].pVtx = (tricnt * 3 * Vec3f)()
                node.sGeomData.pMap[i].nVtxSize = c_int(tricnt * 3)
                node.sGeomData.pMap[i].pIdx = (tricnt * TriIdx)()
                node.sGeomData.pMap[i].nIdxSize = c_int(tricnt)
        else:
            bNeedUVWs = False

    if bNeedVertexColours:
        VCData = []
        for vc in vertex_colors:
            if vc.active_render:
                VCData = vc.data # We've found an active vertex colour layer
                break
        if VCData:
            node.sGeomData.pCol = (tricnt * 3 * Vec4f)()
            node.sGeomData.nColSize = c_int(tricnt * 3)
        else:
            bNeedVertexColours = False
    
    if bNeedSkinning:
        node.pModData = (1 * Modifier)()
        node.nModDataSize = 1
        node.pModData[0].pVtx = (tricnt * 3 * BonedVtx)()
        node.pModData[0].nVtxSize = (tricnt * 3)
        maxInfNo = pvrgeopod.lib.getInfNoSupported()
        
    # Fill our data structures with mesh data
    vertices = mesh.vertices
    tri_idx = [0,1,2,0,2,3]
    cnt = 0
    bReportedOutOfRangeError = False
    
    for faceidx, face in enumerate(faces):
        triangles = len(face.vertices) - 2
        for i in range(triangles):
            node.sGeomData.pFace[cnt] = PODFace() # Initialise to default values
            for j in range(3):
                vertIdx = tri_idx[j + (i * 3)]
                vertex = vertices[face.vertices[vertIdx]]
                idx = cnt * 3 + j
                
                # Set our vertex position
                node.sGeomData.pVtx[idx].x = vertex.co.x
                node.sGeomData.pVtx[idx].y = vertex.co.y
                node.sGeomData.pVtx[idx].z = vertex.co.z
                node.sGeomData.pFace[cnt].sVtx.i[j] = idx
                
                # If needed fill our our UVs
                if bNeedUVWs:
                    for k in range(channelCnt):
                        node.sGeomData.pMap[k].pVtx[idx].x = UVData[k][faceidx].uv[vertIdx][0]
                        node.sGeomData.pMap[k].pVtx[idx].y = UVData[k][faceidx].uv[vertIdx][1]
                        node.sGeomData.pMap[k].pVtx[idx].z = 0
                        node.sGeomData.pMap[k].pIdx[cnt].i[j] = idx
                        
                # If needed fill out our normals
                if bNeedNormals:
                    if face.use_smooth:
                        n = vertex.normal
                    else:
                        n = face.normal
                        
                    node.sGeomData.pNrm[idx].x = n.x
                    node.sGeomData.pNrm[idx].y = n.y
                    node.sGeomData.pNrm[idx].z = n.z
                    node.sGeomData.pFace[cnt].sNrm.i[j] = idx

                # If needed fill out our vertex colours
                if bNeedVertexColours:
                    if vertIdx == 0:
                        col = VCData[faceidx].color1
                    elif vertIdx == 1:
                        col = VCData[faceidx].color2
                    elif vertIdx == 2:
                        col = VCData[faceidx].color3
                    else:
                        col = VCData[faceidx].color4
                    node.sGeomData.pCol[idx].x = col[0]
                    node.sGeomData.pCol[idx].y = col[1]
                    node.sGeomData.pCol[idx].z = col[2]
                    node.sGeomData.pCol[idx].w = 1.0
                    node.sGeomData.pFace[cnt].sVtxCol.i[j] = idx
        
                # If needed fill out our skinning information
                if bNeedSkinning:
                    boneList = []
                    
                    for grp in vertex.groups:
                        if grp.group < len(vertex_groups):
                            key = armature.name + " | " + vertex_groups[grp.group].name
   
                            if key in pvrgeopod.nodemap:
                                if grp.weight > 0.0: # If weight is zero then ignore the bone as it has no influence
                                    pos = len(boneList)
                                    for x in range(pos):
                                        if boneList[x][1] < grp.weight:
                                            pos = x
                                            break;
                                            
                                    # Insert our bone in the list so they are ordered by their weight
                                    boneList.insert(pos, [pvrgeopod.nodemap[key], grp.weight])
                            else:
                                if not key in pvrgeopod.missingnodes:
                                    pvrgeopod.print({'WARNING'}, "Couldn't find bone '" + key + "' which is needed for skinning.")
                                    pvrgeopod.missingnodes.append(key)
                        else:
                            if not bReportedOutOfRangeError:
                                pvrgeopod.print({'WARNING'}, "Some groups are out of range of our vertex group")
                                bReportedOutOfRangeError = True
                            
                    infNo = len(boneList)

                    if infNo == 0: # Hmmm this vertex isn't attached to any bones...
                        if armature.name in pvrgeopod.nodemap:
                            boneList.insert(0, [pvrgeopod.nodemap[armature.name], 1.0]) # ... so we're going to attach them to our armature root node (which POD is using as a root bone for connecting up floating bones)
                            infNo = 1
                            
                    if infNo > maxInfNo:
                        infNo = maxInfNo     

                    node.pModData[0].pVtx[idx].pBone = (infNo * BoneWeight)()
                    node.pModData[0].pVtx[idx].nBoneSize = infNo
                    for bone in range(infNo):
                        node.pModData[0].pVtx[idx].pBone[bone].nBone   = boneList[bone][0]
                        node.pModData[0].pVtx[idx].pBone[bone].fWeight = c_float(boneList[bone][1])

                # Set the material for this face
                if bNeedMaterials:
                    matid = -1
                    if face.material_index < len(materiallist):
                        matid = materiallist[face.material_index]

                    node.sGeomData.pFace[cnt].i32MatID = matid
                
            cnt += 1 
    
    # We're done with our mesh so remove it if we created it
    if not mesh == obj.data:
        bpy.data.meshes.remove(mesh)

    # Pass the completed mesh node to our native library
    id = pvrgeopod.lib.addNode(byref(node))
    pvrgeopod.nodemap[obj.name] = id
    return id
            
def AddCamera(pvrgeopod, camera, parentID):
    node = PODNode()
    node.nParentID  = parentID
    node.pName      = GetString(camera, pvrgeopod)
    node.eNodeType  = pvrgeopod.eCamera
    node.transformation.set(camera.matrix_local)
    
    # CameraData should be filled in
    node.sCameraData.fFOV       = c_float(camera.data.angle) # This is in degrees but the C++ part will convert to Radians for the pod format
    node.sCameraData.fFarClip   = c_float(camera.data.clip_end)
    node.sCameraData.fNearClip  = c_float(camera.data.clip_start)
    
    # TODO: target node
    node.sLightData.nTargetID = -1     # The node ID for the camera to look at
            
    # Pass the completed camera node to our native library
    id = pvrgeopod.lib.addNode(byref(node))
    pvrgeopod.nodemap[camera.name] = id
    return id

def AddLight(pvrgeopod, light, parentID):
    node = PODNode()
    node.nParentID  = parentID
    node.pName      = GetString(light, pvrgeopod)
    node.eNodeType  = pvrgeopod.eLight
    node.transformation.set(light.matrix_local)

    # LightData should be filled in
    if light.data.type == 'POINT':
        node.sLightData.eType = c_int(pvrgeopod.ePoint)		
        node.sLightData.fConstantAttenuation  = c_float(1.0 - light.data.energy)
        node.sLightData.fLinearAttenuation    = c_float(light.data.linear_attenuation)
        node.sLightData.fQuadraticAttenuation = c_float(light.data.quadratic_attenuation)
    elif light.data.type == 'SUN':
        node.sLightData.eType = c_int(pvrgeopod.eDirectional)
    elif light.data.type == 'SPOT':
        node.sLightData.eType = c_int(pvrgeopod.eSpot)
        node.sLightData.fFalloffAngle		  = c_float(radians(light.data.spot_size))
        node.sLightData.fFalloffExponent	  = c_float(0.0)			
        node.sLightData.fConstantAttenuation  = c_float(1.0 - light.data.energy) # TODO: Is this right?
        node.sLightData.fLinearAttenuation    = c_float(light.data.linear_attenuation)
        node.sLightData.fQuadraticAttenuation = c_float(light.data.quadratic_attenuation)
    else:
        return -1 # Unsupported type
    
    node.sLightData.pColour = Vec3f(light.data.color[0], light.data.color[1], light.data.color[2])
    
    # TODO: target node
    node.sLightData.nTargetID = -1     # The node ID for the light to look at
            
    # Pass the completed light node to our native library
    id = pvrgeopod.lib.addNode(byref(node))
    pvrgeopod.nodemap[light.name] = id
    return id

def AddEmptyNode(pvrgeopod, obj, parentID, type):
    node = PODNode()
    node.nParentID  = parentID
    node.pName      = GetString(obj, pvrgeopod)
    node.eNodeType  = type
    node.transformation.set(obj.matrix_local)

    # Pass the completed camera node to our native library
    id = pvrgeopod.lib.addNode(byref(node))
    pvrgeopod.nodemap[obj.name] = id
    return id
 
def AddAnimation(pvrgeopod):
    scene = bpy.context.scene
    
    startFrame = scene.frame_start
    endFrame = scene.frame_end

    if endFrame - startFrame == 0: # No frames of animation
        return

    animatedObjects = []
    animatedBones = []
    
    # Construct a list of objects we need to add animation to
    for obj in scene.objects:
        if obj.name in pvrgeopod.nodemap: # and obj.animation_data: # TODO: Removing objects based on animation_data may not be a good idea
            x = [obj, pvrgeopod.nodemap[obj.name]]
            animatedObjects.append(x)
        if obj.type == 'ARMATURE':
            for bone in obj.data.bones:
                key = obj.name + " | " + bone.name
                if key in pvrgeopod.nodemap: # and bone.animation_data:
                    x = [obj.pose.bones[bone.name], pvrgeopod.nodemap[key]]
                    animatedBones.append(x)
            
    
    if not len(animatedObjects) and not len(animatedBones):
        return # No objects

    # Loop through the frames and grab the object's transformation matrix
    tmp = Matrixf()

    for frame in range(startFrame, endFrame+1):
        scene.frame_set(frame)
        
        for obj in animatedObjects:
            tmp.set(obj[0].matrix_local)
            pvrgeopod.lib.appendFrame(obj[1], byref(tmp))
        
        for bone in animatedBones:
            if bone[0].parent == None:
                tmp.set(bone[0].matrix)
            else:
                tmp.set(bone[0].parent.matrix.inverted() * bone[0].matrix)
            
            pvrgeopod.lib.appendFrame(bone[1], byref(tmp))                
            
def AddMaterial(pvrgeopod, material):
    if material == None:
        return -1
        
    if not material.__hash__() in pvrgeopod.materialmap: # Has our material already been added?
        node = PODMaterial()
        node.pName = GetString(material, pvrgeopod)
        node.vDiffuse = Vec3f(material.diffuse_color[0], material.diffuse_color[1], material.diffuse_color[2])
        node.vAmbient = Vec3f(material.diffuse_color[0] * material.ambient, material.diffuse_color[1] * material.ambient, material.diffuse_color[2] * material.ambient)
       
        node.vSpecular = Vec3f(material.specular_color[0], material.specular_color[1], material.specular_color[2])
        node.fOpacity = c_float(material.alpha)
        # TODO: check if hardness is ok		
        node.fGlossiness = c_float((material.specular_hardness -1) /float(510))  

        for tex in material.texture_slots:
            if tex and tex.texture and tex.use and tex.texture.type == "IMAGE":
                if tex.use_map_color_diffuse:
                    node.pTexDiffuse = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_ambient:    
                    node.pTexAmbient = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_color_spec:    
                    node.pTexSpecularColour = bpy.path.basename(tex.texture.image.filepath).encode('utf-8') 
                elif tex.use_map_specular:    
                    node.pTexSpecularLevel = bpy.path.basename(tex.texture.image.filepath).encode('utf-8') 
                elif tex.use_map_normal:    
                    node.pTexBump = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_color_emission:    
                    node.pTexEmissive = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_hardness:    
                    node.pTexGlossiness = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_translucency:    
                    node.pTexOpacity = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_color_reflection:    
                    node.pTexReflection = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')
                elif tex.use_map_scatter:    
                    node.pTexRefraction = bpy.path.basename(tex.texture.image.filepath).encode('utf-8')            

        # Pass the completed material node to our native library
        matid = -1
        matid = int(pvrgeopod.lib.addMaterial(byref(node)))
        pvrgeopod.materialmap[material.__hash__()] = matid
        
    return pvrgeopod.materialmap[material.__hash__()]

def AddUnsupportedObject(obj):
    # If the object's children (..or their children..) are supported types then we should add this object as an empty node
    for child in obj.children:
        if child.type == 'MESH' or child.type == 'EMPTY' or child.type == 'CAMERA' or child.type == 'LAMP' or child.type == 'META' or child.type == 'FONT':
            return True
            
        if AddUnsupportedObject(child):
            return True
        
    return False

def AddObject(pvrgeopod, obj, parentID):
    id = -1
    
    if obj.type == 'MESH':
        id = AddMesh(pvrgeopod, obj, parentID)
    elif obj.type == 'ARMATURE':
        id = pvrgeopod.nodemap[obj.name]
        pvrgeopod.lib.updateParent(id,parentID)
    elif obj.type == 'EMPTY':
        id = AddEmptyNode(pvrgeopod, obj, parentID, pvrgeopod.eDummy)
    elif obj.type == 'CAMERA':
        if obj.data.type == 'PERSP': # We only support perspective cameras
            id = AddCamera(pvrgeopod, obj, parentID)
        elif AddUnsupportedObject(obj):
            id = AddEmptyNode(pvrgeopod, obj, parentID, pvrgeopod.eDummy)
    elif obj.type == 'LAMP':
        id = AddLight(pvrgeopod, obj, parentID)
    elif obj.type == 'FONT':
        id = AddMesh(pvrgeopod, obj, parentID)
    elif obj.type == 'META':
        pvrgeopod.print({'WARNING'}, "Warning: Exporting " + obj.name + " as a mesh")
        id = AddMesh(pvrgeopod, obj, parentID)
    elif obj.type == 'LATTICE' or obj.type == 'CURVE' or obj.type == 'SURFACE' or obj.type == 'SPEAKER':
        if AddUnsupportedObject(obj):
            id = AddEmptyNode(pvrgeopod, obj, parentID, pvrgeopod.eDummy)
            pvrgeopod.print({'WARNING'}, "Exporting " + obj.name + " as a dummy node as object type " + obj.type + " is not supported")
    else:
        pvrgeopod.print({'WARNING'}, "Unrecognised object type: " + obj.type)
    
    if id == -1: # Was there an error while adding the object?
        return   # If so, return
        
    # Won't somebody add the children
    for child in obj.children:
        AddObject(pvrgeopod, child, id)

def AddArmatureBone(pvrgeopod, bone, armature, parentID):
    node = PODNode()
    node.nParentID  = parentID
    node.pName      = GetString(bone, pvrgeopod)
    node.eNodeType  = pvrgeopod.eBone
    
    pose = armature.pose.bones[bone.name]

    if pose.parent == None:
        node.transformation.set(pose.matrix)
    else:
        node.transformation.set(pose.parent.matrix.inverted() * pose.matrix)

    # Pass the completed camera node to our native library
    id = pvrgeopod.lib.addNode(byref(node))
    key = armature.name + " | " + bone.name
    pvrgeopod.nodemap[key] = id
    
    for child in bone.children:
        AddArmatureBone(pvrgeopod, child, armature, id)
    
def AddArmature(pvrgeopod, armature):
    id = AddEmptyNode(pvrgeopod, armature, -1, pvrgeopod.eDummy) # Set the parent as -1 for the time being. It'll get updated later if it needs to be different
    
    if id == -1:
        return
        
    for bone in armature.data.bones:
        if bone.parent == None:
            AddArmatureBone(pvrgeopod, bone, armature, id)
        
def AddScene(pvrgeopod):
    ret = True
    scene = bpy.context.scene
  
    curFrame = scene.frame_current
    
    try:
        scene.frame_set(scene.frame_start)
            
        info = PODSceneInfo()
        info.startFrame = scene.frame_start
        info.endFrame   = scene.frame_end
        info.frameRate  = scene.render.fps
        
        if bpy.context.scene.world:
            world_ambient = bpy.context.scene.world.ambient_color
            info.ambient = Vec3f(world_ambient[0],world_ambient[1],world_ambient[2])

        pvrgeopod.lib.setupSceneInfo(byref(info))

        for obj in scene.objects: # Add the armatures and their bones first
            if not obj.type == 'ARMATURE':
                continue
            AddArmature(pvrgeopod, obj)
           
        for obj in scene.objects:
            if obj.parent: # Only add root objects, AddObject will take care of the children
                continue
            AddObject(pvrgeopod, obj, -1)

        AddAnimation(pvrgeopod)
    except Exception as exp:
        pvrgeopod.print({'INFO'}, "*****")
        
        pvrgeopod.print({'ERROR'}, "Error: An exception has been raised in the python script")
        pvrgeopod.print({'ERROR'}, str(exp))
        info = ("".join(traceback.format_tb(sys.exc_info()[2]))).splitlines()
        for line in info:
            pvrgeopod.print({'INFO'}, line)
        
        pvrgeopod.print({'INFO'}, "*****")       
        ret = False
    finally:
        scene.frame_set(curFrame)
    
    return ret

def DoExport(context, filepath, pvrgeopod):
    if not pvrgeopod.loadLibrary():
        return {'CANCELLED'}
    
    podfile = c_char_p(filepath.encode('utf-8','ignore'))
    
    # Display the PVRGeoPOD common options gui
    if pvrgeopod.lib.launchOptions(podfile):
        pvrgeopod.lib.launchOutputDialog()
        
        if AddScene(pvrgeopod):
            # Write our data out to the requested POD file 
            history = "Blender v" + bpy.app.version_string + " | Python v" + platform.python_version()
            if pvrgeopod.lib.savePOD(podfile, c_char_p(history.encode('utf-8','ignore'))):
                pvrgeopod.print({'INFO'}, "Export completed")
                return {'FINISHED'}

        pvrgeopod.print({'ERROR'}, "Export failed")
        return {'FINISHED'}
    else:
        pvrgeopod.print({'INFO'}, "Export cancelled")
        return {'CANCELLED'}

class ExportPOD(bpy.types.Operator, ExportHelper):
    bl_idname = "export_scene.pod"
    bl_label = "Export pod"

    filename_ext = ".pod"
    filter_glob = StringProperty(default="*.pod;*.h;*.cpp", options={'HIDDEN'})

    qualities = [ ( 'PREVIEW' , "Preview", "Preview quality" ), ( 'RENDER' , "Render", "Render quality" ) ]
    enumProp = bpy.props.EnumProperty(name = "Quality", items = qualities, description = "Choose a quality for the mesh data" )
    
    @classmethod
    def poll(cls, context):
       return context.active_object != None
       
    def execute(self, context):
        pvrgeopod = PODBuilder()
        pvrgeopod.quality = self.enumProp
        pvrgeopod.ExportPOD_self = self
        return DoExport(context, self.filepath, pvrgeopod)

    def draw(self, context):
        layout = self.layout
        col = layout.column()
        col.prop(self, "enumProp")
        col.label(text="More options will appear on export")


def menu_func_export(self, context):
    self.layout.operator(ExportPOD.bl_idname, text="PVRGeoPOD (.pod/.h/.cpp)")

def register():
    bpy.utils.register_module(__name__)
    bpy.types.INFO_MT_file_export.append(menu_func_export)

def unregister():
    bpy.utils.unregister_module(__name__)
    bpy.types.INFO_MT_file_export.remove(menu_func_export)

if __name__ == "__main__":
    register()

