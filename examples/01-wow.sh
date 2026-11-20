#!/usr/bin/env bash
# Module 1 "wow" command: semantic code search over the tokio source with pmat.
# Fetches tokio once into corpus/tokio (git-ignored), pinned to a tag, then queries it.
set -euo pipefail
cd "$(dirname "$0")/.."
TOKIO_TAG="${TOKIO_TAG:-tokio-1.43.0}"
command -v pmat >/dev/null || { echo "pmat not found: cargo install pmat" >&2; exit 1; }
if [ ! -d corpus/tokio/.git ]; then
  mkdir -p corpus
  git clone --quiet --depth 1 --branch "$TOKIO_TAG" https://github.com/tokio-rs/tokio corpus/tokio
fi
pmat query "async file IO" -p corpus/tokio
