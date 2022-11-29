#!/bin/bash

set -e
set -o pipefail

IMAGE=davesnx/alpine-esy
VERSION=0.0.1

echo "Publishing $IMAGE:$VERSION image..."
docker push $IMAGE:$VERSION
echo "Done."
