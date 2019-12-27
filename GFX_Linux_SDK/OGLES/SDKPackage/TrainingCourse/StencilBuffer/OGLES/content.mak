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
	$(CONTENTDIR)/Cylinder.cpp \
	$(CONTENTDIR)/Sphere.cpp \
	$(CONTENTDIR)/Lattice.cpp \
	$(CONTENTDIR)/Stone.cpp \
	$(CONTENTDIR)/Tile.cpp

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

$(CONTENTDIR)/Cylinder.cpp:
	$(FILEWRAP)  -o $@ Cylinder.pod

$(CONTENTDIR)/Sphere.cpp:
	$(FILEWRAP)  -o $@ Sphere.pod

$(CONTENTDIR)/Lattice.cpp:
	$(FILEWRAP)  -o $@ Lattice.pvr

$(CONTENTDIR)/Stone.cpp:
	$(FILEWRAP)  -o $@ Stone.pvr

$(CONTENTDIR)/Tile.cpp:
	$(FILEWRAP)  -o $@ Tile.pvr

############################################################################
# End of file (content.mak)
############################################################################
