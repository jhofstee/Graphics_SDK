#!/bin/sh

# just install files in deploy
sdk_install_dir=$PWD
destdir=$(pwd)/deploy

# doesn't need to be the real home dir..
home=$(dirname $PWD)

# assumes linux is checkout next to the Graphics SDK
linux=$(dirname $PWD)/linux
cross_compile=arm-linux-gnueabihf-

# what to build...
build=debug
target=install
support_xorg=1

mkdir -p deploy/etc/init.d
mkdir -p deploy/usr/local

# make it somewhat broken, it always rebuilds and parallel builds don't seem to work
make BUILD=$build OMAPES=3.x FBDEV=yes SUPPORT_XORG=$support_xorg all CROSS_COMPILE=$cross_compile SDK_INSTALL_DIR=$sdk_install_dir DESTDIR=$destdir HOME=$home LINUXKERNEL_INSTALL_DIR=$linux $target V=1
