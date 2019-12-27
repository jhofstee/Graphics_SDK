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
	$(CONTENTDIR)/Text.cpp \
	$(CONTENTDIR)/arial_36.cpp \
	$(CONTENTDIR)/starjout_60.cpp \
	$(CONTENTDIR)/title_36.cpp \
	$(CONTENTDIR)/title_46.cpp \
	$(CONTENTDIR)/title_56.cpp

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

$(CONTENTDIR)/Text.cpp:
	$(FILEWRAP)  -o $@ Text.txt

$(CONTENTDIR)/arial_36.cpp:
	$(FILEWRAP)  -o $@ arial_36.pvr

$(CONTENTDIR)/starjout_60.cpp:
	$(FILEWRAP)  -o $@ starjout_60.pvr

$(CONTENTDIR)/title_36.cpp:
	$(FILEWRAP)  -o $@ title_36.pvr

$(CONTENTDIR)/title_46.cpp:
	$(FILEWRAP)  -o $@ title_46.pvr

$(CONTENTDIR)/title_56.cpp:
	$(FILEWRAP)  -o $@ title_56.pvr

############################################################################
# End of file (content.mak)
############################################################################
