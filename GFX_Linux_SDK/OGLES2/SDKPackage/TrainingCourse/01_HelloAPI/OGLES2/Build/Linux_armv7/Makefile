#
# File			Makefile
# Title			Makes the demo
# Author		PowerVR
#
# Copyright		Copyright (C) by Imagination Technologies Limited.
#

.PHONY: clean

SDKDIR  = ../../../../..
VPATH = ../..

include $(SDKDIR)/Builds/OGLES2/$(PLATFORM)/make_platform.mak

ifeq "$(WS)" "X11"
SRCNAME = OGLES2HelloAPI_LinuxX11
else
ifeq "$(WS)" "EWS"
SRCNAME = OGLES2HelloAPI_EWS
else
SRCNAME = OGLES2HelloAPI_NullWS
endif
endif

OUTNAME = OGLES2HelloAPI

OBJECTS = $(PLAT_OBJPATH)/$(SRCNAME).o

COMMON_INCLUDES = $(addprefix -I, $(PLAT_INC))

$(PLAT_OBJPATH)/$(OUTNAME) : $(OBJECTS) 
	mkdir -p $(PLAT_OBJPATH)
	$(PLAT_CPP) -o $(PLAT_OBJPATH)/$(OUTNAME) $(OBJECTS) $(LINK) $(PLAT_LINK)

$(PLAT_OBJPATH)/%.o: %.cpp
	mkdir -p $(PLAT_OBJPATH)
	$(PLAT_CC) $(PLAT_CFLAGS) -c $(COMMON_INCLUDES) $(INCLUDES) $^ -o $@

clean:
	-rm -rf $(PLAT_OBJPATH) *.o

