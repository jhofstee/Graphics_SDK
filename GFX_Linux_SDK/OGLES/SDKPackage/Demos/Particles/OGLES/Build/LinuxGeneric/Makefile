#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLESParticles

OBJECTS +=	\
           LightTex.o	\
           FloorTex8.o

INCLUDES += 	\
         -I../..

include $(SDKDIR)/Builds/OGLES/LinuxGeneric/make_demo.mak

../../Content/LightTex.cpp ../../Content/FloorTex8.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
