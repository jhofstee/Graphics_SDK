#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLESFur

OBJECTS +=	\
           tBridge.o	\
           tGrass.o	\
           tSkin.o	\
           tWater.o	\
           tCloud.o	\
           tFur.o	\
           Scene.o

include $(SDKDIR)/Builds/OGLES/LinuxGeneric/make_demo.mak

../../Content/tBridge.cpp ../../Content/tGrass.cpp ../../Content/tSkin.cpp ../../Content/tWater.cpp ../../Content/tCloud.cpp ../../Content/tFur.cpp ../../Content/Scene.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
