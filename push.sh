#!/usr/bin/env bash

set -e
set -o pipefail
set -o xtrace

# IMPORTANT: For this to work, you need to
#   pacman -Syu qemu-user-static qemu-user-static-binfmt

if [[ "$#" -ne 2 ]]; then
    echo "$0 [MINECRAFT VERSION] [PAPER BUILD#]" >&2
    exit 2
fi

MC_VERSION=$1
PAPER_BUILD=$2

IMG="images.lit.plus/papermc:${MC_VERSION}-${PAPER_BUILD}"

if podman image exists $IMG; then
  podman image rm $IMG
fi

if podman manifest exists $IMG; then
  podman manifest rm $IMG
fi

podman manifest create $IMG
podman build \
    --platform linux/amd64,linux/arm64 \
    --build-arg MC_VERSION=${MC_VERSION} \
    --build-arg PAPER_BUILD=${PAPER_BUILD} \
    --manifest $IMG \
    .
podman manifest push $IMG
