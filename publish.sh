#!/bin/bash

set -e
set -o pipefail

IMAGE=davesnx/alpine-esy
VERSION=0.0.1

DOCKER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=== Building $IMAGE:$VERSION image..."
docker build -f "$DOCKER_DIR"/Dockerfile -t $IMAGE:$VERSION "$DOCKER_DIR"
echo ""

echo "=== Publishing $IMAGE:$VERSION image..."
docker push $IMAGE:$VERSION
echo ""

echo "Done."
