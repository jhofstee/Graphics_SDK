function DefineNodeUserData nodeid =
(
	/* Return the nodes name and class type as a string to be included in the POD node for nodeid */
	node = maxOps.getNodeByHandle nodeid
	str = stringstream ""
	format "% is of type " node.name  to:str
	print (superClassOf node) to:str
	str as string
)

function DefineMaterialUserData matid subid =
(
	mat = sceneMaterials[matid]
	superClassOf mat
	
	/* Is our material a subobject material */
	if isKindOf mat multimaterial then
	(
		/* If it is a subobject material return its name and parent material name */
		str = stringstream ""
		submat = mat.materialList[subid]
		format "%:%" mat.name submat.name to:str
		return str as string
	)

	/* 
		Our material is just a material. We're going to return the diffuse colour 
		but we're going to do it in a structured way using a MAXScript array. The
		first value will be a unique tag to identify that we're exporting the 
		diffuse value. The second value will be the data size and the third vale
		is the material's diffuse value.
	*/
	
	h = #()
	append h 3004  			/* The POD tag for diffuse */
	append h (4 * 3) 		/* The size of the diffuse data (3 floats) */
	append h mat.diffuse 	/* The diffuse data */
	
	/* return our data */
	h
)

function DefineSceneUserData =
(
	/*
		Anything returned from this function will be included in the SPODScene's user data.
		This is for information that doesn't belong with a node or a material.
	*/
	"Extra global data"
)

