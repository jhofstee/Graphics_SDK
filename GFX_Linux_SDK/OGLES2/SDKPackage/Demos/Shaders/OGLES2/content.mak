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
	$(CONTENTDIR)/Basetex.cpp \
	$(CONTENTDIR)/Reflection.cpp \
	$(CONTENTDIR)/Cubemap.cpp \
	$(CONTENTDIR)/AnisoMap.cpp \
	$(CONTENTDIR)/anisotropic_lighting.cpp \
	$(CONTENTDIR)/directional_lighting.cpp \
	$(CONTENTDIR)/envmap.cpp \
	$(CONTENTDIR)/fasttnl.cpp \
	$(CONTENTDIR)/lattice.cpp \
	$(CONTENTDIR)/phong_lighting.cpp \
	$(CONTENTDIR)/point_lighting.cpp \
	$(CONTENTDIR)/reflections.cpp \
	$(CONTENTDIR)/simple.cpp \
	$(CONTENTDIR)/spot_lighting.cpp \
	$(CONTENTDIR)/toon.cpp \
	$(CONTENTDIR)/vertex_sine.cpp \
	$(CONTENTDIR)/wood.cpp

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

$(CONTENTDIR)/Basetex.cpp:
	$(FILEWRAP)  -o $@ Basetex.pvr

$(CONTENTDIR)/Reflection.cpp:
	$(FILEWRAP)  -o $@ Reflection.pvr

$(CONTENTDIR)/Cubemap.cpp:
	$(FILEWRAP)  -o $@ Cubemap.pvr

$(CONTENTDIR)/AnisoMap.cpp:
	$(FILEWRAP)  -o $@ AnisoMap.pvr

$(CONTENTDIR)/anisotropic_lighting.cpp:
	$(FILEWRAP)  -s  -o $@ anisotropic_lighting.pfx

$(CONTENTDIR)/directional_lighting.cpp:
	$(FILEWRAP)  -s  -o $@ directional_lighting.pfx

$(CONTENTDIR)/envmap.cpp:
	$(FILEWRAP)  -s  -o $@ envmap.pfx

$(CONTENTDIR)/fasttnl.cpp:
	$(FILEWRAP)  -s  -o $@ fasttnl.pfx

$(CONTENTDIR)/lattice.cpp:
	$(FILEWRAP)  -s  -o $@ lattice.pfx

$(CONTENTDIR)/phong_lighting.cpp:
	$(FILEWRAP)  -s  -o $@ phong_lighting.pfx

$(CONTENTDIR)/point_lighting.cpp:
	$(FILEWRAP)  -s  -o $@ point_lighting.pfx

$(CONTENTDIR)/reflections.cpp:
	$(FILEWRAP)  -s  -o $@ reflections.pfx

$(CONTENTDIR)/simple.cpp:
	$(FILEWRAP)  -s  -o $@ simple.pfx

$(CONTENTDIR)/spot_lighting.cpp:
	$(FILEWRAP)  -s  -o $@ spot_lighting.pfx

$(CONTENTDIR)/toon.cpp:
	$(FILEWRAP)  -s  -o $@ toon.pfx

$(CONTENTDIR)/vertex_sine.cpp:
	$(FILEWRAP)  -s  -o $@ vertex_sine.pfx

$(CONTENTDIR)/wood.cpp:
	$(FILEWRAP)  -s  -o $@ wood.pfx

############################################################################
# End of file (content.mak)
############################################################################
