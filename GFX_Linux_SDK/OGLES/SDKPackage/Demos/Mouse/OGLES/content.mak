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
	$(CONTENTDIR)/FloorToon.cpp \
	$(CONTENTDIR)/MouseToon.cpp \
	$(CONTENTDIR)/Toon.cpp \
	$(CONTENTDIR)/WallToon.cpp \
	$(CONTENTDIR)/Mouse.cpp

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

$(CONTENTDIR)/FloorToon.cpp:
	$(FILEWRAP)  -o $@ FloorToon.pvr

$(CONTENTDIR)/MouseToon.cpp:
	$(FILEWRAP)  -o $@ MouseToon.pvr

$(CONTENTDIR)/Toon.cpp:
	$(FILEWRAP)  -o $@ Toon.pvr

$(CONTENTDIR)/WallToon.cpp:
	$(FILEWRAP)  -o $@ WallToon.pvr

$(CONTENTDIR)/Mouse.cpp:
	$(FILEWRAP)  -o $@ Mouse.pod

############################################################################
# End of file (content.mak)
############################################################################
