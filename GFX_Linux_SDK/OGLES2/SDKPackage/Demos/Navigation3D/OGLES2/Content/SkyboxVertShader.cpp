// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: SkyboxVertShader.vsh ********

// File data
static const char _SkyboxVertShader_vsh[] = 
	"attribute mediump vec3 inVertex;\r\n"
	"\r\n"
	"uniform mediump mat4 ModelViewProjMatrix;\r\n"
	"\r\n"
	"varying mediump vec3 vEyeDir;\r\n"
	"\r\n"
	"void main()\r\n"
	"{\t\r\n"
	"\tvEyeDir = -inVertex.xzy;\r\n"
	"\tgl_Position = ModelViewProjMatrix * vec4(inVertex, 1.0);\t\r\n"
	"}";

// Register SkyboxVertShader.vsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_SkyboxVertShader_vsh("SkyboxVertShader.vsh", _SkyboxVertShader_vsh, 219);

// ******** End: SkyboxVertShader.vsh ********

