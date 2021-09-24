#!/bin/bash
set -e -u -x

# https://github.com/pypa/manylinux

docker pull quay.io/pypa/manylinux_2_24_x86_64
docker run --rm -e PLAT=manylinux_2_24_x86_64 -v `pwd`:/io quay.io/pypa/manylinux_2_24_x86_64 /io/_manylinux.sh