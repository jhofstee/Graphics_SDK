#--------------------------------------------------------------------------
# Name         : content.mak
# Title        : Makefile to build content files
#
# Copyright    : Copyright (C)  Imagination Technologies Limited.
#              : No part of this software, either material or conceptual 
#              : may be copied or distributed, transmitted, transcribed,
#              : stored in a retrieval system or translated into any 
#              : human or computer language in any form by any means,
#              : electronic, mechanical, manual or other-wise, or 
#              : disclosed to third parties without the express written
#              : permission of VideoLogic Limited, Unit 8, HomePark
#              : Industrial Estate, King's Langley, Hertfordshire,
#              : WD4 8LZ, U.K.
#
# Description  : Makefile to wrap content files for examples in the PowerVR SDK
#
# Platform     :
#
#--------------------------------------------------------------------------

#############################################################################
## Variables
#############################################################################
FILEWRAP 	= ..\..\..\..\Utilities\Filewrap\Windows_x86_32\Filewrap.exe
CONTENTDIR = Content

#############################################################################
## Instructions
#############################################################################

RESOURCES = \
	$(CONTENTDIR)/NewNormalMap.cpp \
	$(CONTENTDIR)/Mountain.cpp \
	$(CONTENTDIR)/wood.cpp \
	$(CONTENTDIR)/sail.cpp \
	$(CONTENTDIR)/MountainFloor.cpp \
	$(CONTENTDIR)/FragShader.cpp \
	$(CONTENTDIR)/VertShader.cpp \
	$(CONTENTDIR)/SkyboxFShader.cpp \
	$(CONTENTDIR)/SkyboxVShader.cpp \
	$(CONTENTDIR)/ModelFShader.cpp \
	$(CONTENTDIR)/ModelVShader.cpp \
	$(CONTENTDIR)/Tex2DFShader.cpp \
	$(CONTENTDIR)/Tex2DVShader.cpp \
	$(CONTENTDIR)/PlaneTexFShader.cpp \
	$(CONTENTDIR)/PlaneTexVShader.cpp \
	$(CONTENTDIR)/Scene.cpp

all: resources
	
help:
	@echo Valid targets are:
	@echo resources, clean
	@echo FILEWRAP can be used to override the default path to the Filewrap utility.

clean:
	-rm $(RESOURCES)

resources: $(CONTENTDIR) $(RESOURCES)

$(CONTENTDIR):
	-mkdir $@

$(CONTENTDIR)/NewNormalMap.cpp:
	$(FILEWRAP)  -o $@ NewNormalMap.pvr

$(CONTENTDIR)/Mountain.cpp:
	$(FILEWRAP)  -o $@ Mountain.pvr

$(CONTENTDIR)/wood.cpp:
	$(FILEWRAP)  -o $@ wood.pvr

$(CONTENTDIR)/sail.cpp:
	$(FILEWRAP)  -o $@ sail.pvr

$(CONTENTDIR)/MountainFloor.cpp:
	$(FILEWRAP)  -o $@ MountainFloor.pvr

$(CONTENTDIR)/FragShader.cpp:
	$(FILEWRAP)  -s  -o $@ FragShader.fsh
	-$(FILEWRAP)  -oa $@ FragShader.fsc

$(CONTENTDIR)/VertShader.cpp:
	$(FILEWRAP)  -s  -o $@ VertShader.vsh
	-$(FILEWRAP)  -oa $@ VertShader.vsc

$(CONTENTDIR)/SkyboxFShader.cpp:
	$(FILEWRAP)  -s  -o $@ SkyboxFShader.fsh
	-$(FILEWRAP)  -oa $@ SkyboxFShader.fsc

$(CONTENTDIR)/SkyboxVShader.cpp:
	$(FILEWRAP)  -s  -o $@ SkyboxVShader.vsh
	-$(FILEWRAP)  -oa $@ SkyboxVShader.vsc

$(CONTENTDIR)/ModelFShader.cpp:
	$(FILEWRAP)  -s  -o $@ ModelFShader.fsh
	-$(FILEWRAP)  -oa $@ ModelFShader.fsc

$(CONTENTDIR)/ModelVShader.cpp:
	$(FILEWRAP)  -s  -o $@ ModelVShader.vsh
	-$(FILEWRAP)  -oa $@ ModelVShader.vsc

$(CONTENTDIR)/Tex2DFShader.cpp:
	$(FILEWRAP)  -s  -o $@ Tex2DFShader.fsh
	-$(FILEWRAP)  -oa $@ Tex2DFShader.fsc

$(CONTENTDIR)/Tex2DVShader.cpp:
	$(FILEWRAP)  -s  -o $@ Tex2DVShader.vsh
	-$(FILEWRAP)  -oa $@ Tex2DVShader.vsc

$(CONTENTDIR)/PlaneTexFShader.cpp:
	$(FILEWRAP)  -s  -o $@ PlaneTexFShader.fsh
	-$(FILEWRAP)  -oa $@ PlaneTexFShader.fsc

$(CONTENTDIR)/PlaneTexVShader.cpp:
	$(FILEWRAP)  -s  -o $@ PlaneTexVShader.vsh
	-$(FILEWRAP)  -oa $@ PlaneTexVShader.vsc

$(CONTENTDIR)/Scene.cpp:
	$(FILEWRAP)  -o $@ WaterScene.pod

############################################################################
# End of file (content.mak)
############################################################################
