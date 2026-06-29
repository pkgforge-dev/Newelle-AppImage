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
# python-sounddevice is a dependency to pocketsphinx
make-aur-package python-sounddevice && make-aur-package pocketsphinx
# python-proto-plus is a dependency to python-grpcio-status
make-aur-package python-proto-plus && make-aur-package python-grpcio-status
# python-grpcio-status and python-proto-plus are a dependency to python-google-cloud-speech,
# python-google-cloud-speech and python-groq are a dependency to python-speechrecognition
make-aur-package python-groq && make-aur-package python-google-cloud-speech && make-aur-package python-speechrecognition
make-aur-package python-openwakeword
make-aur-package llama.cpp
make-aur-package python-llama-index-core
make-aur-package python-model2vec
make-aur-package python-tokenizers
make-aur-package faiss-cpu
make-aur-package python-ddgs
make-aur-package python-fake-useragent
make-aur-package
