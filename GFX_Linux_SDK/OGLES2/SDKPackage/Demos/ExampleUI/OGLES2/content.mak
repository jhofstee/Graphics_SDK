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
	$(CONTENTDIR)/SpriteShaderF.cpp \
	$(CONTENTDIR)/SpriteShaderV.cpp \
	$(CONTENTDIR)/TexColShaderF.cpp \
	$(CONTENTDIR)/TexColShaderV.cpp \
	$(CONTENTDIR)/ColShaderF.cpp \
	$(CONTENTDIR)/ColShaderV.cpp \
	$(CONTENTDIR)/container-corner.cpp \
	$(CONTENTDIR)/container-vertical.cpp \
	$(CONTENTDIR)/container-horizontal.cpp \
	$(CONTENTDIR)/topbar.cpp \
	$(CONTENTDIR)/background.cpp \
	$(CONTENTDIR)/clock-face.cpp \
	$(CONTENTDIR)/clock-face-small.cpp \
	$(CONTENTDIR)/hand.cpp \
	$(CONTENTDIR)/hand-small.cpp \
	$(CONTENTDIR)/battery.cpp \
	$(CONTENTDIR)/internet-web-browser.cpp \
	$(CONTENTDIR)/mail-message-new.cpp \
	$(CONTENTDIR)/network-wireless.cpp \
	$(CONTENTDIR)/office-calendar.cpp \
	$(CONTENTDIR)/weather-sun-cloud.cpp \
	$(CONTENTDIR)/weather-storm.cpp \
	$(CONTENTDIR)/weather-rain.cpp \
	$(CONTENTDIR)/text1.cpp \
	$(CONTENTDIR)/text2.cpp \
	$(CONTENTDIR)/text-weather.cpp \
	$(CONTENTDIR)/text-fri.cpp \
	$(CONTENTDIR)/text-sat.cpp \
	$(CONTENTDIR)/text-sun.cpp \
	$(CONTENTDIR)/text-mon.cpp \
	$(CONTENTDIR)/weather-sun-cloud-big.cpp \
	$(CONTENTDIR)/window-bottom.cpp \
	$(CONTENTDIR)/window-bottomcorner.cpp \
	$(CONTENTDIR)/window-side.cpp \
	$(CONTENTDIR)/window-top.cpp \
	$(CONTENTDIR)/window-topleft.cpp \
	$(CONTENTDIR)/window-topright.cpp \
	$(CONTENTDIR)/loremipsum.cpp

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

$(CONTENTDIR)/SpriteShaderF.cpp:
	$(FILEWRAP)  -s  -o $@ SpriteShaderF.fsh
	-$(FILEWRAP)  -oa $@ SpriteShaderF.fsc

$(CONTENTDIR)/SpriteShaderV.cpp:
	$(FILEWRAP)  -s  -o $@ SpriteShaderV.vsh
	-$(FILEWRAP)  -oa $@ SpriteShaderV.vsc

$(CONTENTDIR)/TexColShaderF.cpp:
	$(FILEWRAP)  -s  -o $@ TexColShaderF.fsh
	-$(FILEWRAP)  -oa $@ TexColShaderF.fsc

$(CONTENTDIR)/TexColShaderV.cpp:
	$(FILEWRAP)  -s  -o $@ TexColShaderV.vsh
	-$(FILEWRAP)  -oa $@ TexColShaderV.vsc

$(CONTENTDIR)/ColShaderF.cpp:
	$(FILEWRAP)  -s  -o $@ ColShaderF.fsh
	-$(FILEWRAP)  -oa $@ ColShaderF.fsc

$(CONTENTDIR)/ColShaderV.cpp:
	$(FILEWRAP)  -s  -o $@ ColShaderV.vsh
	-$(FILEWRAP)  -oa $@ ColShaderV.vsc

$(CONTENTDIR)/container-corner.cpp:
	$(FILEWRAP)  -o $@ container-corner.pvr

$(CONTENTDIR)/container-vertical.cpp:
	$(FILEWRAP)  -o $@ container-vertical.pvr

$(CONTENTDIR)/container-horizontal.cpp:
	$(FILEWRAP)  -o $@ container-horizontal.pvr

$(CONTENTDIR)/topbar.cpp:
	$(FILEWRAP)  -o $@ topbar.pvr

$(CONTENTDIR)/background.cpp:
	$(FILEWRAP)  -o $@ background.pvr

$(CONTENTDIR)/clock-face.cpp:
	$(FILEWRAP)  -o $@ clock-face.pvr

$(CONTENTDIR)/clock-face-small.cpp:
	$(FILEWRAP)  -o $@ clock-face-small.pvr

$(CONTENTDIR)/hand.cpp:
	$(FILEWRAP)  -o $@ hand.pvr

$(CONTENTDIR)/hand-small.cpp:
	$(FILEWRAP)  -o $@ hand-small.pvr

$(CONTENTDIR)/battery.cpp:
	$(FILEWRAP)  -o $@ battery.pvr

$(CONTENTDIR)/internet-web-browser.cpp:
	$(FILEWRAP)  -o $@ internet-web-browser.pvr

$(CONTENTDIR)/mail-message-new.cpp:
	$(FILEWRAP)  -o $@ mail-message-new.pvr

$(CONTENTDIR)/network-wireless.cpp:
	$(FILEWRAP)  -o $@ network-wireless.pvr

$(CONTENTDIR)/office-calendar.cpp:
	$(FILEWRAP)  -o $@ office-calendar.pvr

$(CONTENTDIR)/weather-sun-cloud.cpp:
	$(FILEWRAP)  -o $@ weather-sun-cloud.pvr

$(CONTENTDIR)/weather-storm.cpp:
	$(FILEWRAP)  -o $@ weather-storm.pvr

$(CONTENTDIR)/weather-rain.cpp:
	$(FILEWRAP)  -o $@ weather-rain.pvr

$(CONTENTDIR)/text1.cpp:
	$(FILEWRAP)  -o $@ text1.pvr

$(CONTENTDIR)/text2.cpp:
	$(FILEWRAP)  -o $@ text2.pvr

$(CONTENTDIR)/text-weather.cpp:
	$(FILEWRAP)  -o $@ text-weather.pvr

$(CONTENTDIR)/text-fri.cpp:
	$(FILEWRAP)  -o $@ text-fri.pvr

$(CONTENTDIR)/text-sat.cpp:
	$(FILEWRAP)  -o $@ text-sat.pvr

$(CONTENTDIR)/text-sun.cpp:
	$(FILEWRAP)  -o $@ text-sun.pvr

$(CONTENTDIR)/text-mon.cpp:
	$(FILEWRAP)  -o $@ text-mon.pvr

$(CONTENTDIR)/weather-sun-cloud-big.cpp:
	$(FILEWRAP)  -o $@ weather-sun-cloud-big.pvr

$(CONTENTDIR)/window-bottom.cpp:
	$(FILEWRAP)  -o $@ window-bottom.pvr

$(CONTENTDIR)/window-bottomcorner.cpp:
	$(FILEWRAP)  -o $@ window-bottomcorner.pvr

$(CONTENTDIR)/window-side.cpp:
	$(FILEWRAP)  -o $@ window-side.pvr

$(CONTENTDIR)/window-top.cpp:
	$(FILEWRAP)  -o $@ window-top.pvr

$(CONTENTDIR)/window-topleft.cpp:
	$(FILEWRAP)  -o $@ window-topleft.pvr

$(CONTENTDIR)/window-topright.cpp:
	$(FILEWRAP)  -o $@ window-topright.pvr

$(CONTENTDIR)/loremipsum.cpp:
	$(FILEWRAP)  -o $@ loremipsum.pvr

############################################################################
# End of file (content.mak)
############################################################################
