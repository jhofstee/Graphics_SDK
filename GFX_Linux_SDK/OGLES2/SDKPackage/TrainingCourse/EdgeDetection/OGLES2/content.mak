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
	$(CONTENTDIR)/PreFragShader.cpp \
	$(CONTENTDIR)/PreVertShader.cpp \
	$(CONTENTDIR)/PostFragShader.cpp \
	$(CONTENTDIR)/PostVertShader.cpp \
	$(CONTENTDIR)/SketchObject.cpp

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

$(CONTENTDIR)/PreFragShader.cpp:
	$(FILEWRAP)  -s  -o $@ PreFragShader.fsh
	-$(FILEWRAP)  -oa $@ PreFragShader.fsc

$(CONTENTDIR)/PreVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ PreVertShader.vsh
	-$(FILEWRAP)  -oa $@ PreVertShader.vsc

$(CONTENTDIR)/PostFragShader.cpp:
	$(FILEWRAP)  -s  -o $@ PostFragShader.fsh
	-$(FILEWRAP)  -oa $@ PostFragShader.fsc

$(CONTENTDIR)/PostVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ PostVertShader.vsh
	-$(FILEWRAP)  -oa $@ PostVertShader.vsc

$(CONTENTDIR)/SketchObject.cpp:
	$(FILEWRAP)  -o $@ SketchObject.pod

############################################################################
# End of file (content.mak)
############################################################################
