// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: VertShader.vsh ********

// File data
static const char _VertShader_vsh[] = 
	"attribute highp vec3 inVertex;\r\n"
	"attribute highp vec3 inNormal;\r\n"
	"\r\n"
	"uniform highp mat4  uModelViewMatrix;\r\n"
	"uniform highp mat3  uModelViewITMatrix;\r\n"
	"uniform highp mat4  uModelViewProjectionMatrix;\r\n"
	"\r\n"
	"uniform highp vec3  uLightPosition;\r\n"
	"\r\n"
	"varying highp vec3  vNormal;\r\n"
	"varying highp vec3  vLightDirection;\r\n"
	"\r\n"
	"void main()\r\n"
	"{\r\n"
	"\tgl_Position = uModelViewProjectionMatrix * vec4(inVertex, 1.0);\r\n"
	"\tvNormal = uModelViewITMatrix * inNormal;\r\n"
	"\r\n"
	"\thighp vec3 position = (uModelViewMatrix * vec4(inVertex, 1.0)).xyz;\r\n"
	"\tvLightDirection = uLightPosition - position;\r\n"
	"}\r\n";

// Register VertShader.vsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_VertShader_vsh("VertShader.vsh", _VertShader_vsh, 553);

// ******** End: VertShader.vsh ********

