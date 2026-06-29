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
make-aur-package python-sounddevice && make-aur-package pocketsphinx
make-aur-package python-proto-plus && make-aur-package python-grpcio-status
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
