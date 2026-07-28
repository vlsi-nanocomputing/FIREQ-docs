#!/usr/bin/env bash
set -e

echo "Synchronizing FIREQ component documentation..."

rm -rf docs/imported

mkdir -p docs/imported/client
mkdir -p docs/imported/firmware
mkdir -p docs/imported/server

cp -r ../FIREQ-Client/docs/* docs/imported/client/
cp -r ../FIREQ/docs/* docs/imported/firmware/
cp -r ../FIREQ-Server/docs/* docs/imported/server/

echo "Done."
echo "Imported documentation:"
echo "  docs/imported/client/"
echo "  docs/imported/firmware/"
echo "  docs/imported/server/"
