// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: UIVertShader.vsh ********

// File data
static const char _UIVertShader_vsh[] = 
	"attribute highp   vec2  inVertex;\r\n"
	"attribute mediump vec2  inTexCoord;\r\n"
	"\r\n"
	"uniform   highp   mat2  RotationMatrix;\r\n"
	"\r\n"
	"varying   mediump vec2  vTexCoord;\r\n"
	"\r\n"
	"void main()\r\n"
	"{\t\r\n"
	"\thighp vec2 vertex = RotationMatrix * inVertex;\r\n"
	"\tgl_Position = vec4(vertex, 0.0, 1.0);\t\r\n"
	"\tvTexCoord = inTexCoord;\r\n"
	"}\r\n";

// Register UIVertShader.vsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_UIVertShader_vsh("UIVertShader.vsh", _UIVertShader_vsh, 291);

// ******** End: UIVertShader.vsh ********

