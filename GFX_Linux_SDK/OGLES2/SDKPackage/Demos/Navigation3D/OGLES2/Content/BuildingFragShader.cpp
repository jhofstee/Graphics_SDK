// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: BuildingFragShader.fsh ********

// File data
static const char _BuildingFragShader_fsh[] = 
	"uniform lowp sampler2D sTexture;\r\n"
	"uniform lowp vec4   FlatColour;\r\n"
	"\r\n"
	"varying highp vec2  vTexCoord;\r\n"
	"varying highp float vDiffuse;\r\n"
	"\r\n"
	"\r\n"
	"void main()\r\n"
	"{\t\r\n"
	"\tlowp vec4 colour = texture2D(sTexture, vTexCoord);\r\n"
	"\tgl_FragColor.rgb = colour.rgb * vDiffuse;\t\r\n"
	"\tgl_FragColor.a = colour.a;\t\r\n"
	"}\r\n";

// Register BuildingFragShader.fsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_BuildingFragShader_fsh("BuildingFragShader.fsh", _BuildingFragShader_fsh, 284);

// ******** End: BuildingFragShader.fsh ********

