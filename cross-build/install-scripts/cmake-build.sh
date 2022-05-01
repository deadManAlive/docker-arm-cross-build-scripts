#!/usr/bin/env bash

set -ex

# Download
version=3.23.1
arch=$(uname -m)
URL="https://github.com/Kitware/CMake/releases/download/v$version/cmake-$version-Linux-$arch.sh"
pushd "${DOWNLOADS}"
wget -N "$URL"

chmod +x cmake-$version-Linux-$arch.sh
sudo ./cmake-$version-Linux-$arch.sh \
    --prefix="/usr/local" \
    --exclude-subdir \
    --skip-license

rm cmake-$version-Linux-$arch.sh
popd