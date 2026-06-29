#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q newelle | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.qwersyk.Newelle.svg
export DESKTOP=/usr/share/applications/io.github.qwersyk.Newelle.desktop
export DEPLOY_PYTHON=1
export DEPLOY_GTK=1
export DEPLOY_WEBKIT2GTK=1
export GTK_DIR=gtk-4.0
export DEPLOY_LOCALE=1
export STARTUPWMCLASS=io.github.qwersyk.Newelle
export GTK_CLASS_FIX=1

# Deploy dependencies
quick-sharun /usr/bin/newelle \
             /usr/lib/libgirepository*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
