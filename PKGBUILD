# Maintainer: fiftydinar <srbaizoki4@tuta.io>

pkgname=newelle
pkgver=1.4.5
pkgrel=1
pkgdesc="Your Ultimate Virtual Assistant - GTK4 AI assistant"
arch=('x86_64' 'aarch64')
url="https://github.com/qwersyk/Newelle"
license=('GPL-3.0-only')

depends=(
  # === SYSTEM LIBRARIES ===
  'gtk4' 'libadwaita' 'gtksourceview5' 'vte4' 'webkitgtk-6.0'
  'glib2' 'desktop-file-utils' 'adwaita-icon-theme'
  'gsettings-desktop-schemas' 'glib-networking'

  # === PYTHON CORE (module-level, crash if missing) ===
  'python' 'python-gobject' 'python-pylatexenc' 'python-tldextract'
  'python-expandvars' 'python-requests' 'python-pillow' 'python-lxml'
  'python-yaml' 'python-click' 'python-colorama' 'python-filelock'
  'python-regex'

  # === OPTIONAL: ML / Scientific (heavy deps, used by multiple handlers) ===
  'python-numpy'        # opt: numpy, used by embeddings/memory/rag handlers
  'python-matplotlib'   # opt: matplotlib, inline LaTeX rendering in chat
  'python-tiktoken'     # opt: tiktoken, token counting for context
  'python-scikit-learn' # opt: scikit-learn, used by openwakeword
  'python-scipy'        # opt: scipy, used by openwakeword
  'python-nltk'         # opt: nltk, used by newspaper/llamaindex
  'python-joblib'       # opt: joblib, used by newspaper/llamaindex

  # === OPTIONAL: LLM backends (app is useless without at least one) ===
  'python-openai'       # opt: openai, primary API handler (also used by Groq, OpenRouter etc.)
  'python-ollama'       # opt: ollama (AUR), popular local LLM backend

  # === OPTIONAL: Audio / Voice ===
  'python-pyaudio'      # opt: pyaudio, audio capture/recording
  'python-pydub'        # opt: pydub, audio processing (imported by edge_handler)
  'python-gtts'         # opt: gtts, Google Text-to-Speech

  # === OPTIONAL: Web search / Article reading ===
  'python-newspaper'     # opt: newspaper3k (AUR), article extraction
  'python-beautifulsoup4'# opt: bs4, HTML parsing (lazy in website_scraper)
  'python-soupsieve'     # opt: soupsieve, transitive via bs4
  'python-markdownify'   # opt: markdownify, HTML→Markdown (lazy in website_scraper)
  'python-lxml-html-clean'# opt: lxml-html-clean, HTML sanitization

  # === OPTIONAL: STT / Wakeword ===
  'python-speechrecognition' # opt: speechrecognition (AUR)
  'python-openwakeword'      # opt: openwakeword (AUR), wake word detection

  # === OPTIONAL: RAG / Embeddings / Vector DB ===
  'python-llama-index-core'     # opt: llama-index-core (AUR), RAG framework
  'python-model2vec'            # opt: model2vec (AUR), local embeddings
  'python-tokenizers'           # opt: tokenizers (AUR)
  'faiss-cpu'                   # opt: faiss-cpu (AUR), vector database
  'python-huggingface-hub'      # opt: huggingface-hub, model downloads
  'python-safetensors'          # opt: safetensors

  # === OPTIONAL: Local model server ===
  'llama.cpp'                   # opt: llama.cpp (AUR), provides llama-server binary

  # === OPTIONAL: Web search backends ===
  'python-ddgs'                 # opt: ddgs (AUR), DuckDuckGo search
  'python-fake-useragent'       # opt: fake-useragent (AUR)

  # === OPTIONAL: Tools / API server ===
  'python-mcp'                  # opt: mcp, MCP tool protocol
  'python-fastapi'              # opt: fastapi, API interface server (pulls uvicorn)
  'python-onnxruntime-cpu'      # opt: onnxruntime, ML inference runtime (heavy)
)

makedepends=(
  'meson' 'ninja' 'git' 'python-build' 'python-wheel'
  'python-setuptools-rust' 'jq' 'python-pip'
)

source=("$pkgname-$pkgver.tar.gz::https://github.com/qwersyk/Newelle/archive/refs/tags/$pkgver.tar.gz")
sha256sums=('SKIP')
b2sums=('SKIP')

pkgver() {
  curl -sL "https://api.github.com/repos/qwersyk/Newelle/releases/latest" |
    jq -r '.tag_name' | sed 's/^v//'
}

package() {
  local _pkgdir="$srcdir/Newelle-$pkgver"
  cd "$_pkgdir"

  # Install deps not in repos or AUR
  pip install \
    --prefix=/usr \
    --root="$pkgdir" \
    pysilero-vad \
    llama-index-readers-file \
    llama-index-vector-stores-faiss

  # Build with meson
  arch-meson . build \
    -Dprofile=release \
    --libdir=lib
  ninja -C build
  DESTDIR="$pkgdir" ninja -C build install

  install -Dm644 COPYING "$pkgdir/usr/share/licenses/$pkgname/COPYING"
}
