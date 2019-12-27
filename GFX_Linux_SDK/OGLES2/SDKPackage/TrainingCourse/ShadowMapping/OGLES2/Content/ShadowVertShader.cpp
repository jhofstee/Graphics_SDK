// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: ShadowVertShader.vsh ********

// File data
static const char _ShadowVertShader_vsh[] = 
	"attribute highp vec3  inVertex;\r\n"
	"attribute highp vec3  inNormal;\r\n"
	"attribute mediump vec2  inTexCoord;\r\n"
	"\r\n"
	"uniform highp mat4 TexProjectionMatrix;\r\n"
	"uniform\thighp mat4 ProjectionMatrix;\r\n"
	"uniform highp mat4 ModelViewMatrix;\r\n"
	"uniform highp vec3 LightDirection;\r\n"
	"\r\n"
	"varying highp vec4 vProjCoord;\r\n"
	"varying mediump vec2 texCoord;\r\n"
	"varying lowp vec3 LightIntensity;\r\n"
	"\r\n"
	"void main()\r\n"
	"{\r\n"
	"\thighp vec4 modelViewPos = ModelViewMatrix * vec4(inVertex, 1.0);\r\n"
	"\tgl_Position = ProjectionMatrix * modelViewPos;\r\n"
	"\tvProjCoord = TexProjectionMatrix * modelViewPos;\r\n"
	"\r\n"
	"\ttexCoord = inTexCoord;\r\n"
	"\t\r\n"
	"\t// Simple diffuse lighting in model space\r\n"
	"\tLightIntensity = vec3(dot(inNormal, -LightDirection));\r\n"
	"}\r\n";

// Register ShadowVertShader.vsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_ShadowVertShader_vsh("ShadowVertShader.vsh", _ShadowVertShader_vsh, 677);

// ******** End: ShadowVertShader.vsh ********

