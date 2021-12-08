#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

echo 'deb http://deb.debian.org/debian buster-backports main' > /etc/apt/sources.list.d/backports.list

apt-get -qq update
apt-get -qq -y --no-install-recommends -t buster-backports install maven
apt-get -qq -y --no-install-recommends install \
    build-essential \
    python3.7-dev
rm -rf /var/lib/apt/lists/*

dpkg --list
