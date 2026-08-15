#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q exult | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/info.exult.exult.svg
export DESKTOP=/usr/share/applications/info.exult.exult.desktop
export STARTUPWMCLASS=exult
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/exult /usr/lib/libfluidsynth.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage
