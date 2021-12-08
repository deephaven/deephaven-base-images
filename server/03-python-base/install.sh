#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

apt-get -qq update
apt-get -qq -y --no-install-recommends install \
    python3.7 \
    libpython3.7 \
    python3-pip \
    python3-setuptools \
    python3-wheel
rm -rf /var/lib/apt/lists/*

python3 -m pip install -q --no-cache-dir --upgrade pip
python3 -m pip install -q --no-cache-dir --upgrade setuptools
python3 -m pip install -q --no-cache-dir --upgrade wheel

dpkg --list
