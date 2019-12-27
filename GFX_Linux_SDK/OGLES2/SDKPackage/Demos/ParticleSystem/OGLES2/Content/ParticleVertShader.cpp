// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: ParticleVertShader.vsh ********

// File data
static const char _ParticleVertShader_vsh[] = 
	"attribute highp vec3  inPosition;\r\n"
	"attribute highp float inLifespan;\r\n"
	"\r\n"
	"uniform highp mat4  uModelViewProjectionMatrix;\r\n"
	"\r\n"
	"varying mediump vec2 vTexCoord;\r\n"
	"\r\n"
	"void main()\r\n"
	"{\r\n"
	"\tgl_Position = uModelViewProjectionMatrix * vec4(inPosition, 1.0);\r\n"
	"\tgl_PointSize = 3.0;\r\n"
	"\tfloat scale = clamp(inLifespan / 20.0, 0.0, 1.0);\r\n"
	"\tscale = scale * scale;\r\n"
	"\tvTexCoord.st = vec2(scale, scale);\r\n"
	"}\r\n";

// Register ParticleVertShader.vsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_ParticleVertShader_vsh("ParticleVertShader.vsh", _ParticleVertShader_vsh, 381);

// ******** End: ParticleVertShader.vsh ********

