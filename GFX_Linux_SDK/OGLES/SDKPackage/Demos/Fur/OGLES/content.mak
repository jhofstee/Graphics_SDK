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
	$(CONTENTDIR)/tBridge.cpp \
	$(CONTENTDIR)/tGrass.cpp \
	$(CONTENTDIR)/tSkin.cpp \
	$(CONTENTDIR)/tWater.cpp \
	$(CONTENTDIR)/tCloud.cpp \
	$(CONTENTDIR)/tFur.cpp \
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

$(CONTENTDIR)/tBridge.cpp:
	$(FILEWRAP)  -o $@ tBridge.pvr

$(CONTENTDIR)/tGrass.cpp:
	$(FILEWRAP)  -o $@ tGrass.pvr

$(CONTENTDIR)/tSkin.cpp:
	$(FILEWRAP)  -o $@ tSkin.pvr

$(CONTENTDIR)/tWater.cpp:
	$(FILEWRAP)  -o $@ tWater.pvr

$(CONTENTDIR)/tCloud.cpp:
	$(FILEWRAP)  -o $@ tCloud.pvr

$(CONTENTDIR)/tFur.cpp:
	$(FILEWRAP)  -o $@ tFur.pvr

$(CONTENTDIR)/Scene.cpp:
	$(FILEWRAP)  -o $@ Scene.pod

############################################################################
# End of file (content.mak)
############################################################################
