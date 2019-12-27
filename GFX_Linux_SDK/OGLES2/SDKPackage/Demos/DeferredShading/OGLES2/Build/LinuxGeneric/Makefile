#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLES2DeferredShading

OBJECTS +=	\
           effect.o	\
           scene.o	\
           pointlight.o	\
           light_cubemap.o	\
           mask_texture.o	\
           mask_bump.o

include $(SDKDIR)/Builds/OGLES2/LinuxGeneric/make_demo.mak

../../Content/effect.cpp ../../Content/scene.cpp ../../Content/pointlight.cpp ../../Content/light_cubemap.cpp ../../Content/mask_texture.cpp ../../Content/mask_bump.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
