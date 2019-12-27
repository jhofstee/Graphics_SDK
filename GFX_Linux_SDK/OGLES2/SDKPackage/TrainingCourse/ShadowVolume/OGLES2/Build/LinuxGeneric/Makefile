#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLES2ShadowVolume

OBJECTS +=	\
           BaseFragShader.o	\
           BaseVertShader.o	\
           ConstFragShader.o	\
           ShadowVolVertShader.o	\
           FullscreenVertShader.o	\
           scene.o	\
           Background.o	\
           Rust.o

include $(SDKDIR)/Builds/OGLES2/LinuxGeneric/make_demo.mak

../../Content/BaseFragShader.cpp ../../Content/BaseVertShader.cpp ../../Content/ConstFragShader.cpp ../../Content/ShadowVolVertShader.cpp ../../Content/FullscreenVertShader.cpp ../../Content/scene.cpp ../../Content/Background.cpp ../../Content/Rust.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
