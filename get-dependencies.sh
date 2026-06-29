#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building package dependencies and package..."
echo "---------------------------------------------------------------"
make-aur-package python-ollama
make-aur-package python-newspaper
make-aur-package python-speechrecognition
make-aur-package python-openwakeword
make-aur-package llama.cpp
make-aur-package python-llama-index-core
make-aur-package python-model2vec
make-aur-package python-tokenizers
make-aur-package faiss-cpu
make-aur-package python-ddgs
make-aur-package python-fake-useragent
make-aur-package


# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
