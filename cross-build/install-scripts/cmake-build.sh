#!/usr/bin/env bash

set -ex

# Download
version=3.23.1
URL="https://github.com/Kitware/CMake/releases/download/v$version/cmake-$version-Linux-x86_64.sh"
pushd "${DOWNLOADS}"
wget -N "$URL"

chmod +x cmake-$version-Linux-x86_64.sh
sudo ./cmake-$version-Linux-x86_64.sh \
    --prefix="/usr/local" \
    --exclude-subdir \
    --skip-license

rm cmake-$version-Linux-x86_64.sh
popd