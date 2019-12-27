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
	$(CONTENTDIR)/balloon.cpp \
	$(CONTENTDIR)/skybox1.cpp \
	$(CONTENTDIR)/skybox2.cpp \
	$(CONTENTDIR)/skybox3.cpp \
	$(CONTENTDIR)/skybox4.cpp \
	$(CONTENTDIR)/skybox5.cpp \
	$(CONTENTDIR)/skybox6.cpp \
	$(CONTENTDIR)/HotAirBalloon.cpp

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

$(CONTENTDIR)/balloon.cpp:
	$(FILEWRAP)  -o $@ balloon.pvr

$(CONTENTDIR)/skybox1.cpp:
	$(FILEWRAP)  -o $@ skybox1.pvr

$(CONTENTDIR)/skybox2.cpp:
	$(FILEWRAP)  -o $@ skybox2.pvr

$(CONTENTDIR)/skybox3.cpp:
	$(FILEWRAP)  -o $@ skybox3.pvr

$(CONTENTDIR)/skybox4.cpp:
	$(FILEWRAP)  -o $@ skybox4.pvr

$(CONTENTDIR)/skybox5.cpp:
	$(FILEWRAP)  -o $@ skybox5.pvr

$(CONTENTDIR)/skybox6.cpp:
	$(FILEWRAP)  -o $@ skybox6.pvr

$(CONTENTDIR)/HotAirBalloon.cpp:
	$(FILEWRAP)  -o $@ HotAirBalloon.pod

############################################################################
# End of file (content.mak)
############################################################################
