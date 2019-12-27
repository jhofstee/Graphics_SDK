SOURCES += "GFX_Linux_KM/services4/3rdparty/linux_drm/*.c"
SOURCES += "GFX_Linux_KM/services4/3rdparty/dc_omapfb3_linux/*.c"
SOURCES += "GFX_Linux_KM/services4/srvkm/env/linux/*.c"
SOURCES += "GFX_Linux_KM/services4/system/omap3/*.c"
SOURCES += "GFX_Linux_KM/services4/srvkm/bridged/*.c"
SOURCES += "GFX_Linux_KM/services4/srvkm/common/*.c"
SOURCES += "GFX_Linux_SDK/OGLES/SDKPackage/Shell/OS/LinuxRaw/*.cpp"
SOURCES += "tools/devmem2/devmem2.c"

INCLUDEPATH += "GFX_Linux_KM/services4/srvkm/include"
INCLUDEPATH += "GFX_Linux_KM/services4/include"
INCLUDEPATH += "GFX_Linux_KM/services4/srvkm/devices/sgx"
INCLUDEPATH += "GFX_Linux_KM/services4/srvkm/hwdefs"
INCLUDEPATH += "GFX_Linux_KM/services4/srvkm/env/linux"
INCLUDEPATH += "../linux/include"
INCLUDEPATH += "../linux/include/generated"

HEADERS += "GFX_Linux_KM/services4/srvkm/env/linux/*.h"
HEADERS += "../linux/include/generated/*.h"

OTHER_FILES += "build.sh"

DEFINES += SUPPORT_DRI_DRM
