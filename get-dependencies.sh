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
# python-google-cloud-speech, python-groq and pocketsphinx are a dependency to python-speechrecognition
make-aur-package python-groq && make-aur-package python-google-cloud-speech && make-aur-package python-speechrecognition
# python-tflite-runtime is a dependency to python-openwakeword
make-aur-package python-tflite-runtime && make-aur-package python-openwakeword
# python-gguf is a dependency to llama.cpp
make-aur-package python-gguf && make-aur-package llama.cpp
# python-banks, python-dataclasses-json, python-llama-index-instrumentation and python-llama-index-workflows are dependencies to python-llama-index-core
make-aur-package python-banks && make-aur-package python-dataclasses-json && make-aur-package python-llama-index-instrumentation && make-aur-package python-llama-index-workflows && make-aur-package python-llama-index-core
# python-tokenizers is a dependency to python-model2vec
make-aur-package python-tokenizers && make-aur-package python-model2vec
make-aur-package faiss-cpu
# python-fake-useragent and python-primp are dependencies to python-ddgs
make-aur-package python-fake-useragent && make-aur-package python-primp && make-aur-package python-ddgs
make-aur-package
