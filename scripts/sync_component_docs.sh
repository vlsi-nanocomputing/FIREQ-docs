#!/usr/bin/env bash
set -euo pipefail

echo "Synchronizing FIREQ component documentation..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="${ROOT_DIR}/fireq-release.yaml"
CACHE_DIR="${ROOT_DIR}/.cache/component-docs"
DOCS_DIR="${ROOT_DIR}/docs/repos"

rm -rf "${DOCS_DIR}"
mkdir -p "${DOCS_DIR}"
mkdir -p "${CACHE_DIR}"

get_yaml_value() {
  python - "$MANIFEST" "$1" "$2" <<'PY'
import sys
import yaml

manifest, section, key = sys.argv[1:]

with open(manifest, "r", encoding="utf-8") as f:
    data = yaml.safe_load(f)

print(data["repositories"][section][key])
PY
}

sync_repo_docs() {
  local manifest_key="$1"
  local name="$2"

  local repository
  local ref
  local clone_dir
  local dst_dir

  repository="$(get_yaml_value "${manifest_key}" "repository")"
  ref="$(get_yaml_value "${manifest_key}" "ref")"

  clone_dir="${CACHE_DIR}/${name}"
  dst_dir="${DOCS_DIR}/${name}"

  echo "  ${repository}@${ref}"

  rm -rf "${clone_dir}"

  git clone \
    --depth 1 \
    --branch "${ref}" \
    "https://github.com/${repository}.git" \
    "${clone_dir}"

  mkdir -p "${dst_dir}"

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
    --exclude='*' \
    "${clone_dir}/" \
    "${dst_dir}/"
}

sync_repo_docs "client" "FIREQ-Client"
sync_repo_docs "firmware" "FIREQ"
sync_repo_docs "server" "FIREQ-Server"

echo
echo "Done."
echo "Staged documentation:"
echo "  docs/repos/FIREQ-Client/"
echo "  docs/repos/FIREQ/"
echo "  docs/repos/FIREQ-Server/"