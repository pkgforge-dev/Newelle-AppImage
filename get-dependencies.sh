#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Installing pre-built packages from Arch Linux CN..."
echo "---------------------------------------------------------------"
make-aur-package --archlinuxcn \
  python-sounddevice \
  pocketsphinx \
  llama.cpp \
  python-tokenizers \
  python-fake-useragent

echo "Building remaining packages from source..."
echo "---------------------------------------------------------------"

_clean_srcdir() {
  for d in "$@"; do
    rm -rf "./$d"
  done
}

make-aur-package python-ollama && _clean_srcdir python-ollama
make-aur-package python-newspaper && _clean_srcdir python-newspaper

# python-proto-plus is a dependency to python-grpcio-status
make-aur-package python-proto-plus && make-aur-package python-grpcio-status && _clean_srcdir python-proto-plus python-grpcio-status

# python-grpcio-status and python-proto-plus are a dependency to python-google-cloud-speech,
# python-google-cloud-speech, python-groq and pocketsphinx are a dependency to python-speechrecognition
make-aur-package python-groq && make-aur-package python-google-cloud-speech && make-aur-package python-speechrecognition && _clean_srcdir python-groq python-google-cloud-speech python-speechrecognition

# python-tflite-runtime is a dependency to python-openwakeword
make-aur-package python-tflite-runtime && make-aur-package python-openwakeword && _clean_srcdir python-tflite-runtime python-openwakeword

# python-sentencepiece is a dependency of python-gguf (only in AUR/Chaotic-AUR)
make-aur-package --chaotic-aur python-sentencepiece
# python-gguf is a dependency to llama.cpp (already installed via archlinuxcn)
make-aur-package python-gguf && _clean_srcdir python-gguf

# python-banks, python-llama-index-instrumentation and python-llama-index-workflows are dependencies to python-llama-index-core
make-aur-package python-banks && make-aur-package python-llama-index-instrumentation && PRE_BUILD_CMDS="pacman -S --noconfirm python-pip; pip install 'uv_build>=0.9.10,<=0.11.16'; sed -i \"s/ 'python-uv-build'//g\" PKGBUILD; sed -i \"s/'python-uv-build' //g\" PKGBUILD" make-aur-package python-llama-index-workflows && make-aur-package python-llama-index-core && _clean_srcdir python-banks python-llama-index-instrumentation python-llama-index-workflows python-llama-index-core

# python-tokenizers is a dependency to python-model2vec (tokenizers already installed via archlinuxcn)
make-aur-package python-model2vec && _clean_srcdir python-model2vec

PRE_BUILD_CMDS="sed -i 's/cmake --build build -j/cmake --build build -j1/g' PKGBUILD; sed -i \"s/pkgname=('faiss-cpu' 'faiss-gpu')/pkgname=('faiss-cpu')/\" PKGBUILD" make-aur-package faiss && _clean_srcdir faiss

# python-fake-useragent and python-primp are dependencies to python-ddgs (fake-useragent already installed via archlinuxcn)
make-aur-package python-primp && PRE_BUILD_CMDS="sed -i 's/^check()/check___disabled()/' PKGBUILD" make-aur-package python-ddgs && _clean_srcdir python-primp python-ddgs

make-aur-package
