#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

apt-get -qq update
apt-get -qq -y --no-install-recommends install \
    python3.7 \
    libpython3.7 \
    python3-venv
rm -rf /var/lib/apt/lists/*

dpkg --list
