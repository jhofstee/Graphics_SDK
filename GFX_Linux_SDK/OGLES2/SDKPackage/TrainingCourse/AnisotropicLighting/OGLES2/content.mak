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
	$(CONTENTDIR)/FastFragShader.cpp \
	$(CONTENTDIR)/FastVertShader.cpp \
	$(CONTENTDIR)/SlowFragShader.cpp \
	$(CONTENTDIR)/SlowVertShader.cpp \
	$(CONTENTDIR)/Mask.cpp \
	$(CONTENTDIR)/Basetex.cpp

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

$(CONTENTDIR)/FastFragShader.cpp:
	$(FILEWRAP)  -s  -o $@ FastFragShader.fsh
	-$(FILEWRAP)  -oa $@ FastFragShader.fsc

$(CONTENTDIR)/FastVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ FastVertShader.vsh
	-$(FILEWRAP)  -oa $@ FastVertShader.vsc

$(CONTENTDIR)/SlowFragShader.cpp:
	$(FILEWRAP)  -s  -o $@ SlowFragShader.fsh
	-$(FILEWRAP)  -oa $@ SlowFragShader.fsc

$(CONTENTDIR)/SlowVertShader.cpp:
	$(FILEWRAP)  -s  -o $@ SlowVertShader.vsh
	-$(FILEWRAP)  -oa $@ SlowVertShader.vsc

$(CONTENTDIR)/Mask.cpp:
	$(FILEWRAP)  -o $@ Mask.pod

$(CONTENTDIR)/Basetex.cpp:
	$(FILEWRAP)  -o $@ Basetex.pvr

############################################################################
# End of file (content.mak)
############################################################################
