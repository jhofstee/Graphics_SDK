#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLESPolyBump

OBJECTS +=	\
           Head_clonespacePVRTC.o	\
           Head_clonespaceBGRA.o	\
           Head_diffuse.o	\
           Head.o

include $(SDKDIR)/Builds/OGLES/LinuxGeneric/make_demo.mak

../../Content/Head_clonespacePVRTC.cpp ../../Content/Head_clonespaceBGRA.cpp ../../Content/Head_diffuse.cpp ../../Content/Head.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
