#!/usr/bin/env bash
set -euo pipefail

source dependencies.sh

mkdir -p ~/.byond/bin
wget -nv -O ~/.byond/bin/librust_g.so "https://github.com/tgstation/rust-g/releases/download/1.0.2/librust_g.so"
chmod +x ~/.byond/bin/librust_g.so
ldd ~/.byond/bin/librust_g.so
