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
	$(CONTENTDIR)/FragShader.cpp \
	$(CONTENTDIR)/VertShader.cpp \
	$(CONTENTDIR)/Box.cpp \
	$(CONTENTDIR)/base_COLOR.cpp \
	$(CONTENTDIR)/base_NRM.cpp \
	$(CONTENTDIR)/base_DISP.cpp \
	$(CONTENTDIR)/base_SPEC.cpp

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

$(CONTENTDIR)/FragShader.cpp:
	$(FILEWRAP)  -s  -o $@ FragShader.fsh
	-$(FILEWRAP)  -oa $@ FragShader.fsc

$(CONTENTDIR)/VertShader.cpp:
	$(FILEWRAP)  -s  -o $@ VertShader.vsh
	-$(FILEWRAP)  -oa $@ VertShader.vsc

$(CONTENTDIR)/Box.cpp:
	$(FILEWRAP)  -o $@ Box.POD

$(CONTENTDIR)/base_COLOR.cpp:
	$(FILEWRAP)  -o $@ base_COLOR.pvr

$(CONTENTDIR)/base_NRM.cpp:
	$(FILEWRAP)  -o $@ base_NRM.pvr

$(CONTENTDIR)/base_DISP.cpp:
	$(FILEWRAP)  -o $@ base_DISP.pvr

$(CONTENTDIR)/base_SPEC.cpp:
	$(FILEWRAP)  -o $@ base_SPEC.pvr

############################################################################
# End of file (content.mak)
############################################################################
