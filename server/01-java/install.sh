#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

if [ -f /etc/dpkg/dpkg.cfg.d/docker ]; then \
    # if this file exists, we're likely in "debian:xxx-slim", and locales are thus being excluded so we need to remove that exclusion (since we want locales)
    grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker
    sed -ri '/\/usr\/share\/locale/d' /etc/dpkg/dpkg.cfg.d/docker
    ! grep -q '/usr/share/locale' /etc/dpkg/dpkg.cfg.d/docker
fi

apt-get -qq update
apt-get -qq -y --no-install-recommends install \
    curl \
    locales \
    ca-certificates
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

apt-get -qq -y --no-install-recommends install \
    openjdk-11-jdk-headless
rm -rf /var/lib/apt/lists/*

dpkg --list
