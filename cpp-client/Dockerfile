# syntax=docker/dockerfile:1.4

ARG DISTRO_BASE=ubuntu
ARG DISTRO_VERSION=22.04
FROM $DISTRO_BASE:$DISTRO_VERSION
# DISTRO_BASE may be something like 'registry.access.redhat.com/ubi8/ubi-minimal:8.8'
# In that case DISTRO_BASE_SHORT=ubi
# (ubi are RedHat provided images for development for RHEL).
ARG DISTRO_BASE_SHORT=ubuntu
ARG DEBIAN_FRONTEND="noninteractive"
ARG PREFIX=/opt/deephaven
ARG BUILD_TYPE=Release

#
# Ubuntu/Debian setup + package installs.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "ubuntu" ] || [ "${DISTRO_BASE_SHORT}" == "debian" ] || exit 0; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        locales \
        ca-certificates \
        curl \
        git \
        g++ \
        cmake \
        make \
        gzip \
        build-essential \
        zlib1g-dev \
        libssl-dev \
        dwz \
        ; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    locale-gen en_US.UTF-8; \
    rm -rf /var/lib/apt/lists/*

#
# Fedora/RHEL setup + package installs.
#
# Note ubi-minimal (for RHEL) uses 'microdnf' instead of 'dnf'.
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "fedora" ] || [ "${DISTRO_BASE_SHORT}" = "ubi" ] || exit 0; \
    DNF=`type microdnf >/dev/null 2>&1 && echo 'microdnf --disableplugin=subscription-manager' || echo 'dnf -q'`; \
    $DNF -y update; \
    $DNF -y install \
        git \
        gcc \
        gcc-c++ \
        gzip \
        cmake \
        openssl-devel \
        dwz \
        ; \
    $DNF clean all

#
# Download and build dependent libraries.
#
# We use dwz (https://sourceware.org/dwz/) to compress the debug information
# on builds that include debug information.
#
# For Release builds we don't need to keep the source, otherwise
# a build with debugging information requires the sources to be present.
#
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; \
    mkdir -p ${PREFIX}; \
    cd ${PREFIX}; \
    cp /build-dependencies.sh .; \
    BUILD_TYPE="${BUILD_TYPE}" ./build-dependencies.sh 2>&1 | gzip -9 > build-dependencies.log.gz; \
    rm -fr src/*/build_dir src/*/cmake/build_dir; \
    [ "${BUILD_TYPE}" = "Release" ] || dwz "${PREFIX}/lib"/lib*.so; \
    [ "${BUILD_TYPE}" != "Release" ] || rm -fr "${PREFIX}/src"
