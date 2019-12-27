// This file was created by Filewrap 1.1
// Little endian mode
// DO NOT EDIT

#include "../PVRTMemoryFileSystem.h"

// using 32 bit to guarantee alignment.
#ifndef A32BIT
 #define A32BIT static const unsigned int
#endif

// ******** Start: ShadowFragShader.fsh ********

// File data
static const char _ShadowFragShader_fsh[] = 
	"#ifdef USE_SHADOW_SAMPLERS\r\n"
	"#\textension GL_EXT_shadow_samplers : require\r\n"
	"    uniform sampler2DShadow sShadow;\r\n"
	"#else   \r\n"
	"    uniform highp sampler2D sShadow;\r\n"
	"#endif\r\n"
	"\r\n"
	"uniform sampler2D       sTexture;\r\n"
	"\r\n"
	"varying highp vec4      vProjCoord;\r\n"
	"varying mediump vec2    texCoord;\r\n"
	"varying lowp vec3       LightIntensity;\r\n"
	"\r\n"
	"void main ()\r\n"
	"{\t\r\n"
	"    const lowp float fAmbient = 0.4;\r\n"
	"    \r\n"
	"#ifdef USE_SHADOW_SAMPLERS\r\n"
	"    // Don't completely darken the shadowed areas, assume some ambient light\r\n"
	"    highp float shadowVal = shadow2DProjEXT(sShadow, vProjCoord) * 0.6 + fAmbient;\r\n"
	"#else\r\n"
	"    // Subtract a small magic number to account for floating-point error\r\n"
	"    highp float comp = (vProjCoord.z / vProjCoord.w) - 0.03;\r\n"
	"\thighp float depth = texture2DProj(sShadow, vProjCoord).r;\r\n"
	"    lowp float shadowVal = comp <= depth ? 1.0 : fAmbient;\r\n"
	"#endif\r\n"
	"\tlowp vec3 color = texture2D(sTexture, texCoord).rgb * LightIntensity * shadowVal;\r\n"
	"\tgl_FragColor = vec4(color, 1.0);\r\n"
	"}\r\n"
	"\r\n";

// Register ShadowFragShader.fsh in memory file system at application startup time
static CPVRTMemoryFileSystem RegisterFile_ShadowFragShader_fsh("ShadowFragShader.fsh", _ShadowFragShader_fsh, 969);

// ******** End: ShadowFragShader.fsh ********

