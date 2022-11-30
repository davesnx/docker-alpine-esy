#!/bin/bash

set -e
set -o pipefail

IMAGE=davesnx/docker-alpine-esy
VERSION=dev

DOCKER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Building $IMAGE:$VERSION image..."
docker build -f "$DOCKER_DIR"/Dockerfile -t $IMAGE:$VERSION "$DOCKER_DIR" --platform linux/amd64 --progress plain
echo ""

echo "Done"
