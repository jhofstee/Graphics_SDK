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
	$(CONTENTDIR)/MaskMain.cpp \
	$(CONTENTDIR)/RoomStill.cpp \
	$(CONTENTDIR)/FragShader.cpp \
	$(CONTENTDIR)/SHVertShader.cpp \
	$(CONTENTDIR)/DiffuseVertShader.cpp \
	$(CONTENTDIR)/PhantomMask.cpp

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

$(CONTENTDIR)/MaskMain.cpp:
	$(FILEWRAP)  -o $@ MaskMain.pvr

$(CONTENTDIR)/RoomStill.cpp:
	$(FILEWRAP)  -o $@ RoomStill.pvr

$(CONTENTDIR)/FragShader.cpp:
	$(FILEWRAP)  -s  -o $@ FragShader.fsh
	-$(FILEWRAP)  -oa $@ FragShader.fsc

$(CONTENTDIR)/SHVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ SHVertShader.vsh
	-$(FILEWRAP)  -oa $@ SHVertShader.vsc

$(CONTENTDIR)/DiffuseVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ DiffuseVertShader.vsh
	-$(FILEWRAP)  -oa $@ DiffuseVertShader.vsc

$(CONTENTDIR)/PhantomMask.cpp:
	$(FILEWRAP)  -o $@ PhantomMask.pod

############################################################################
# End of file (content.mak)
############################################################################
