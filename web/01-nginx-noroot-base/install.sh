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
    libnginx-mod-http-dav-ext \
    --option=Dpkg::Options::=--force-confdef
rm -rf /var/lib/apt/lists/*

# Hm. This probably belongs in deephaven-core somewhere instead of here... used by demo system
mkdir -p /data/notebooks
chown nginx:nginx /data/notebooks
mkdir -p /data/layouts
chown nginx:nginx /data/layouts
chown -R nginx:nginx /var/lib/nginx