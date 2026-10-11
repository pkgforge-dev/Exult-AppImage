#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm autoconf-archive fluidsynth glslang sdl3_image sdl3_mixer

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini #sdl2_image-mini

# Comment this out if you need an AUR package
#make-aur-package munt
#make-aur-package exult

# If the application needs to be manually built that has to be done down here
echo "Building Exult..."
echo "---------------------------------------------------------------"
REPO="https://github.com/exult/exult"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --depth 1 "$REPO" ./exult
echo "$VERSION" > ~/version

mkdir -p /usr/share/exult/music
cd ./exult
autoreconf -v -i
./configure --prefix=/usr
make -j$(nproc) install
mv -v ./*.flx ./*.txt /usr/share/exult/
mv -v ./music/*.ogg /usr/share/exult/music
