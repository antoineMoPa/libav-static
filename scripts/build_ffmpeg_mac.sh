#!/bin/bash

# Stop this script if any part fails
set -e

ARCH=$(uname -m)

ORIGINAL_DIR=$(pwd)
pushd .

rm -rf /tmp/ffmpeg-build
mkdir -p /tmp/ffmpeg-build
cd /tmp/ffmpeg-build

# Get dependencies
brew install automake fdk-aac git lame libass libtool libvorbis libvpx \
     opus sdl shtool texi2html theora wget x264 x265 xvid nasm

# Get ffmpeg snapshot
wget https://ffmpeg.org/releases/ffmpeg-5.1.3.tar.xz
mv ffmpeg-5.1.3.tar.xz ffmpeg.tar.xz
tar -xf ffmpeg.tar.xz
rm ffmpeg.tar.xz
mv $(ls -1) ffmpeg

cd ffmpeg

# Build ffmpeg
./configure  --prefix=/tmp/ffmpeg-build --enable-gpl --enable-nonfree --enable-libass \
--enable-libfdk-aac --enable-libfreetype --enable-libmp3lame \
--enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-libopus --enable-libxvid \
--samples=fate-suite/
make

# Install to prefix
make install

# Move lib and includes to original dir
popd

rm -rf ./libav_5_1_3_mac_build_$ARCH
mkdir -p ./libav_5_1_3_mac_build_$ARCH
mv /tmp/ffmpeg-build/lib/ ./libav_5_1_3_mac_build_$ARCH/
mv /tmp/ffmpeg-build/include/ ./libav_5_1_3_mac_build_$ARCH/

# Create archive
tar -cJf libav_5_1_3_mac_build_$ARCH.tar.xz libav_5_1_3_mac_build_$ARCH
