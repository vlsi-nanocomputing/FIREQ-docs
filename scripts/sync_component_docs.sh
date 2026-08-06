#!/usr/bin/env bash
set -euo pipefail

echo "Synchronizing FIREQ component documentation..."

rm -rf docs/repos

mkdir -p docs/repos/FIREQ-Client
mkdir -p docs/repos/FIREQ
mkdir -p docs/repos/FIREQ-Server

sync_repo_docs() {
  local src="$1"
  local dst="$2"
  shift 2
  local extra_includes=("$@")

  echo "  ${src} -> ${dst}"

  rsync -a --delete --prune-empty-dirs \
    --include='*/' \
    --include='docs/***' \
    --include='README.md' \
    --include='readme.md' \
    --include='README.rst' \
    --include='readme.rst' \
    --include='*.png' \
    --include='*.jpg' \
    --include='*.jpeg' \
    --include='*.svg' \
    --include='*.gif' \
    --include='*.pdf' \
    --include='*.drawio' \
    --include='*.py' \
    "${extra_includes[@]}" \
    --exclude='*' \
    "${src}/" "${dst}/"
}

sync_repo_docs "../FIREQ-Client" "docs/repos/FIREQ-Client"
sync_repo_docs "../FIREQ" "docs/repos/FIREQ"
sync_repo_docs "../FIREQ-Server" "docs/repos/FIREQ-Server"

echo "Done."
echo "Staged documentation:"
echo "  docs/repos/FIREQ-Client/docs/"
echo "  docs/repos/FIREQ/docs/"
echo "  docs/repos/FIREQ-Server/docs/"