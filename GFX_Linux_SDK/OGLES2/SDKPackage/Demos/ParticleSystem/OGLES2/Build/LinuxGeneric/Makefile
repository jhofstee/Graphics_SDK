#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLES2ParticleSystem

OBJECTS +=	\
	       ParticleSystemCPU.o	\
           sphere.o	\
           ParticleGradient.o	\
           FragShader.o	\
           VertShader.o	\
           ParticleFragShader.o	\
           ParticleVertShader.o

INCLUDES += 	\
         -I../..

include $(SDKDIR)/Builds/OGLES2/LinuxGeneric/make_demo.mak

../../Content/sphere.cpp ../../Content/ParticleGradient.cpp ../../Content/FragShader.cpp ../../Content/VertShader.cpp ../../Content/ParticleFragShader.cpp ../../Content/ParticleVertShader.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
