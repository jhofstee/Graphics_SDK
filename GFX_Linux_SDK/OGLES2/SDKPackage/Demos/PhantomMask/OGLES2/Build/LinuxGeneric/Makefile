#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLES2PhantomMask

OBJECTS +=	\
           MaskMain.o	\
           RoomStill.o	\
           FragShader.o	\
           SHVertShader.o	\
           DiffuseVertShader.o	\
           PhantomMask.o

include $(SDKDIR)/Builds/OGLES2/LinuxGeneric/make_demo.mak

../../Content/MaskMain.cpp ../../Content/RoomStill.cpp ../../Content/FragShader.cpp ../../Content/SHVertShader.cpp ../../Content/DiffuseVertShader.cpp ../../Content/PhantomMask.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
