#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm autoconf-archive fluidsynth sdl3_image sdl3_mixer

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

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
mv -v ./data/*.flx ./data/*.txt /usr/share/exult/
