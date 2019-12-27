#
# File			Makefile
# Title			Demo makefile
#
# Copyright		Copyright (C) Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
OUTNAME = OGLESSkybox

OBJECTS +=	\
           balloon.o	\
           skybox1.o	\
           skybox2.o	\
           skybox3.o	\
           skybox4.o	\
           skybox5.o	\
           skybox6.o	\
           HotAirBalloon.o

include $(SDKDIR)/Builds/OGLES/LinuxGeneric/make_demo.mak

../../Content/balloon.cpp ../../Content/skybox1.cpp ../../Content/skybox2.cpp ../../Content/skybox3.cpp ../../Content/skybox4.cpp ../../Content/skybox5.cpp ../../Content/skybox6.cpp ../../Content/HotAirBalloon.cpp: wrap_content_files 

%.o: ../../Content/%.cpp
	$(CC) -c $(COMMON_INCLUDES) $(PLAT_INCLUDES) $(INCLUDES) $(COMMON_CFLAGS) $(PLAT_CFLAGS) $(CFLAGS) $^ -o$@

clean:
	-rm -rf $(PLAT_OBJPATH)/*.o
	make -C ../.. -f content.mak clean
