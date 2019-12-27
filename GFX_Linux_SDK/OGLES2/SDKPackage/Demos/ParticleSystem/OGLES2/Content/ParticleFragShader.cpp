// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: ParticleFragShader.fsh ********

// File data
static const char _ParticleFragShader_fsh[] = 
	"uniform sampler2D sTexture;\r\n"
	"\r\n"
	"varying mediump vec2 vTexCoord;\r\n"
	"\r\n"
	"void main()\r\n"
	"{\r\n"
	"\tgl_FragColor = vec4(texture2D(sTexture, vTexCoord).rgb, vTexCoord.s);\r\n"
	"}\r\n";

// Register ParticleFragShader.fsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_ParticleFragShader_fsh("ParticleFragShader.fsh", _ParticleFragShader_fsh, 157);

// ******** End: ParticleFragShader.fsh ********

