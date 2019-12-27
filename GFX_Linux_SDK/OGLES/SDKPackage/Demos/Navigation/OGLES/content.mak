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
	$(CONTENTDIR)/Alphabet.cpp \
	$(CONTENTDIR)/Road.cpp \
	$(CONTENTDIR)/cameratrack.cpp \
	$(CONTENTDIR)/Landmark_meshes.cpp \
	$(CONTENTDIR)/LandUseA_meshes.cpp \
	$(CONTENTDIR)/LandUseB_meshes.cpp \
	$(CONTENTDIR)/MajHwys_meshes.cpp \
	$(CONTENTDIR)/MajHwyShield_text.cpp \
	$(CONTENTDIR)/RailRds_meshes.cpp \
	$(CONTENTDIR)/SecHwys_meshes.cpp \
	$(CONTENTDIR)/SecHwyShield_text.cpp \
	$(CONTENTDIR)/Signs_billboards.cpp \
	$(CONTENTDIR)/Streets_meshes.cpp \
	$(CONTENTDIR)/Streets_text.cpp \
	$(CONTENTDIR)/WaterPoly_meshes.cpp \
	$(CONTENTDIR)/WaterSeg_meshes.cpp

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

$(CONTENTDIR)/Alphabet.cpp:
	$(FILEWRAP)  -o $@ Alphabet.pvr

$(CONTENTDIR)/Road.cpp:
	$(FILEWRAP)  -o $@ Road.pvr

$(CONTENTDIR)/cameratrack.cpp:
	$(FILEWRAP)  -o $@ cameratrack2d.pod

$(CONTENTDIR)/Landmark_meshes.cpp:
	$(FILEWRAP)  -o $@ Landmark_meshes.nav

$(CONTENTDIR)/LandUseA_meshes.cpp:
	$(FILEWRAP)  -o $@ LandUseA_meshes.nav

$(CONTENTDIR)/LandUseB_meshes.cpp:
	$(FILEWRAP)  -o $@ LandUseB_meshes.nav

$(CONTENTDIR)/MajHwys_meshes.cpp:
	$(FILEWRAP)  -o $@ MajHwys_meshes.nav

$(CONTENTDIR)/MajHwyShield_text.cpp:
	$(FILEWRAP)  -o $@ MajHwyShield_text.nav

$(CONTENTDIR)/RailRds_meshes.cpp:
	$(FILEWRAP)  -o $@ RailRds_meshes.nav

$(CONTENTDIR)/SecHwys_meshes.cpp:
	$(FILEWRAP)  -o $@ SecHwys_meshes.nav

$(CONTENTDIR)/SecHwyShield_text.cpp:
	$(FILEWRAP)  -o $@ SecHwyShield_text.nav

$(CONTENTDIR)/Signs_billboards.cpp:
	$(FILEWRAP)  -o $@ Signs_billboards.nav

$(CONTENTDIR)/Streets_meshes.cpp:
	$(FILEWRAP)  -o $@ Streets_meshes.nav

$(CONTENTDIR)/Streets_text.cpp:
	$(FILEWRAP)  -o $@ Streets_text.nav

$(CONTENTDIR)/WaterPoly_meshes.cpp:
	$(FILEWRAP)  -o $@ WaterPoly_meshes.nav

$(CONTENTDIR)/WaterSeg_meshes.cpp:
	$(FILEWRAP)  -o $@ WaterSeg_meshes.nav

############################################################################
# End of file (content.mak)
############################################################################
