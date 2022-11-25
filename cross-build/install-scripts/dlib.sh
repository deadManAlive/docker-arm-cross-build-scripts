#!/usr/bin/env bash

# inspired by benfogle

# build http://dlib.net/

set -ex

BUILD_PYTHON=`which python3.9`
HOST_PYTHON="${RPI_SYSROOT}/usr/local/bin/python3.9"

# download
version=19.24
URL="http://dlib.net/files/dlib-$version.tar.bz2"
pushd "${DOWNLOADS}"
wget -N "$URL" -O dlib-$version.tar.bz2
popd

# extract
tar xjf "${DOWNLOADS}/dlib-$version.tar.bz2"
mkdir dlib-$version/build-arm
apt list --installed

# conf.
. cross-pkg-config
. crossenv/bin/activate
pushd dlib-$version/build-arm
cmake \
    -DCMAKE_C_COMPILER=${HOST_TRIPLE}-gcc \
    -DCMAKE_CXX_COMPILER=${HOST_TRIPLE}-g++ \
    -DCMAKE_SYSTEM_PROCESSOR="${HOST_ARCH}" \
    -DCMAKE_SYSROOT="${RPI_SYSROOT}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="/usr/local" \
    -DCMAKE_C_FLAGS="-O3 -mfpu=neon -fprofile-use -DENABLE_NEON" -DNEON=ON \
    -DPYTHON_EXECUTABLE=${HOST_PYTHON} \
    -DPYTHON3_INCLUDE_PATH="${RPI_SYSROOT}/usr/local/include/python3.9" \
    -DPYTHON3_LIBRARIES="${RPI_SYSROOT}/usr/local/lib/libpython3.9.so" \
    .. \
|| { cat CMakeFiles/CMakeError.log && false; }
cat CMakeFiles/CMakeOutput.log

# build
# cmake --build . --config Release
make -j$(($(nproc) * 2))

# Install
make install DESTDIR="${RPI_SYSROOT}"
make install DESTDIR="${RPI_STAGING}"

# armv8-rpi3-linux-gnueabihf-pkg-config --libs --cflags dlib-1

popd

# py install
pushd dlib-$version

# python setup.py check

# pip install dlib==19.24.0

# CC=${HOST_TRIPLE}-gcc CXX=${HOST_TRIPLE}-g++ \
python setup.py install

# pip install $(ls ./dist/dlib*.whl)1

popd
rm -rf dlib-$version