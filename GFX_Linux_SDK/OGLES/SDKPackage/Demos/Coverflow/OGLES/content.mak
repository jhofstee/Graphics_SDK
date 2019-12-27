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
	$(CONTENTDIR)/Album1.cpp \
	$(CONTENTDIR)/Album2.cpp \
	$(CONTENTDIR)/Album3.cpp \
	$(CONTENTDIR)/Album4.cpp \
	$(CONTENTDIR)/Album5.cpp \
	$(CONTENTDIR)/Album6.cpp \
	$(CONTENTDIR)/Album7.cpp \
	$(CONTENTDIR)/Album8.cpp \
	$(CONTENTDIR)/Album9.cpp \
	$(CONTENTDIR)/Album10.cpp \
	$(CONTENTDIR)/Album11.cpp \
	$(CONTENTDIR)/Album12.cpp \
	$(CONTENTDIR)/Album13.cpp \
	$(CONTENTDIR)/Album14.cpp \
	$(CONTENTDIR)/Album15.cpp \
	$(CONTENTDIR)/Album16.cpp

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

$(CONTENTDIR)/Album1.cpp:
	$(FILEWRAP)  -o $@ Album1.pvr

$(CONTENTDIR)/Album2.cpp:
	$(FILEWRAP)  -o $@ Album2.pvr

$(CONTENTDIR)/Album3.cpp:
	$(FILEWRAP)  -o $@ Album3.pvr

$(CONTENTDIR)/Album4.cpp:
	$(FILEWRAP)  -o $@ Album4.pvr

$(CONTENTDIR)/Album5.cpp:
	$(FILEWRAP)  -o $@ Album5.pvr

$(CONTENTDIR)/Album6.cpp:
	$(FILEWRAP)  -o $@ Album6.pvr

$(CONTENTDIR)/Album7.cpp:
	$(FILEWRAP)  -o $@ Album7.pvr

$(CONTENTDIR)/Album8.cpp:
	$(FILEWRAP)  -o $@ Album8.pvr

$(CONTENTDIR)/Album9.cpp:
	$(FILEWRAP)  -o $@ Album9.pvr

$(CONTENTDIR)/Album10.cpp:
	$(FILEWRAP)  -o $@ Album10.pvr

$(CONTENTDIR)/Album11.cpp:
	$(FILEWRAP)  -o $@ Album11.pvr

$(CONTENTDIR)/Album12.cpp:
	$(FILEWRAP)  -o $@ Album12.pvr

$(CONTENTDIR)/Album13.cpp:
	$(FILEWRAP)  -o $@ Album13.pvr

$(CONTENTDIR)/Album14.cpp:
	$(FILEWRAP)  -o $@ Album14.pvr

$(CONTENTDIR)/Album15.cpp:
	$(FILEWRAP)  -o $@ Album15.pvr

$(CONTENTDIR)/Album16.cpp:
	$(FILEWRAP)  -o $@ Album16.pvr

############################################################################
# End of file (content.mak)
############################################################################
