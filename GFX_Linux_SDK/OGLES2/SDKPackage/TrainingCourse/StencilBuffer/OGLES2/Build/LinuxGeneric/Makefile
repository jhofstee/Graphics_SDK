#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLES2StencilBuffer

OBJECTS +=	\
           FragShader.o	\
           VertShader.o	\
           Cylinder.o	\
           Sphere.o	\
           Lattice.o	\
           Stone.o	\
           Tile.o

include $(SDKDIR)/Builds/OGLES2/LinuxGeneric/make_demo.mak

../../Content/FragShader.cpp ../../Content/VertShader.cpp ../../Content/Cylinder.cpp ../../Content/Sphere.cpp ../../Content/Lattice.cpp ../../Content/Stone.cpp ../../Content/Tile.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
