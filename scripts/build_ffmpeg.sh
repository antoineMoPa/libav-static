#!/bin/bash

# exit on error
set -e

# Build and start ffmpeg builder image
docker build -t ffmpeg-builder -f ./docker-images/ffmpeg-builder.Dockerfile .
container_id=$(docker run -d ffmpeg-builder)

# Copy libs from the container to the host
docker cp $container_id:/ffmpeg-libs .
docker cp $container_id:/ffmpeg-headers .

# Stop and remove the builder container
docker stop $container_id
docker rm $container_id

node ./scripts/remove_unneeded_libs.js
