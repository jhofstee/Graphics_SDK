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
	$(CONTENTDIR)/BaseFragShader.cpp \
	$(CONTENTDIR)/BaseVertShader.cpp \
	$(CONTENTDIR)/ConstFragShader.cpp \
	$(CONTENTDIR)/ShadowVolVertShader.cpp \
	$(CONTENTDIR)/FullscreenVertShader.cpp \
	$(CONTENTDIR)/scene.cpp \
	$(CONTENTDIR)/Background.cpp \
	$(CONTENTDIR)/Rust.cpp

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

$(CONTENTDIR)/BaseFragShader.cpp:
	$(FILEWRAP)  -s  -o $@ BaseFragShader.fsh
	-$(FILEWRAP)  -oa $@ BaseFragShader.fsc

$(CONTENTDIR)/BaseVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ BaseVertShader.vsh
	-$(FILEWRAP)  -oa $@ BaseVertShader.vsc

$(CONTENTDIR)/ConstFragShader.cpp:
	$(FILEWRAP)  -s  -o $@ ConstFragShader.fsh
	-$(FILEWRAP)  -oa $@ ConstFragShader.fsc

$(CONTENTDIR)/ShadowVolVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ ShadowVolVertShader.vsh
	-$(FILEWRAP)  -oa $@ ShadowVolVertShader.vsc

$(CONTENTDIR)/FullscreenVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ FullscreenVertShader.vsh
	-$(FILEWRAP)  -oa $@ FullscreenVertShader.vsc

$(CONTENTDIR)/scene.cpp:
	$(FILEWRAP)  -o $@ scene.pod

$(CONTENTDIR)/Background.cpp:
	$(FILEWRAP)  -o $@ Background.pvr

$(CONTENTDIR)/Rust.cpp:
	$(FILEWRAP)  -o $@ Rust.pvr

############################################################################
# End of file (content.mak)
############################################################################
