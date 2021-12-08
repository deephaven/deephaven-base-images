#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

# these installs are necessary to enable webdav class 2
# https://github.com/arut/nginx-dav-ext-module
apt-get -qq update
apt-get -qq -y --no-install-recommends install \
    nginx-extras \
    libnginx-mod-http-dav-ext
rm -rf /var/lib/apt/lists/*

dpkg --list
