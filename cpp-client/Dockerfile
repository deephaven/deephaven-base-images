# syntax=docker/dockerfile:1.4

ARG DISTRO_BASE=ubuntu
ARG DISTRO_VERSION=22.04
FROM $DISTRO_BASE:$DISTRO_VERSION
# DISTRO_BASE may be something like 'registry.access.redhat.com/ubi8/ubi-minimal:8.8'
# In that case DISTRO_BASE_SHORT=ubi
# (ubi are RedHat provided images for development for RHEL).
ARG DISTRO_BASE_SHORT=ubuntu
ARG DISTRO_VERSION
ARG DEBIAN_FRONTEND="noninteractive"
ARG PREFIX=/opt/deephaven
ARG BUILD_TYPE=Release

#
# Ubuntu/Debian setup + package installs.
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "ubuntu" ] || [ "${DISTRO_BASE_SHORT}" == "debian" ] || exit 0; \
    apt-get -qq update; \
    TZ=Etc/UTC apt-get -qq -y --no-install-recommends install \
        locales \
        tzdata \
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
# For Ubuntu 22.04 specifically, update cmake to newer version, but not too new:
# Ubuntu 22.04 ships with cmake 3.22.1 but Arrow now requires 3.25+.
# We can't update to "latest" cmake 4.x because this conflicts with
# a cmake_minimum_version from cflags that is too old to be supported by cmake 4.x.
# So we (somewhat arbitrarily) pin to 3.31.11
#
RUN set -eux; \
    [ "${DISTRO_BASE_SHORT}" = "ubuntu" ] && [ "${DISTRO_VERSION}" = "22.04" ] || exit 0; \
    apt-get update && apt-get install -y --no-install-recommends ca-certificates gpg wget; \
    wget -qO- https://apt.kitware.com/keys/kitware-archive-latest.asc \
        | gpg --dearmor -o /usr/share/keyrings/kitware-archive-keyring.gpg; \
    echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main" \
        > /etc/apt/sources.list.d/kitware.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends cmake=3.31.11-0kitware1ubuntu22.04.1 cmake-data=3.31.11-0kitware1ubuntu22.04.1; \
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
    BUILD_TYPE="${BUILD_TYPE}" ./build-dependencies.sh > build-dependencies.log 2>&1; \
    gzip -9 build-dependencies.log; \
    rm -fr src/*/build_dir src/*/cmake/build_dir; \
    [ "${BUILD_TYPE}" = "Release" ] || dwz "${PREFIX}/lib"/lib*.so; \
    [ "${BUILD_TYPE}" != "Release" ] || rm -fr "${PREFIX}/src"

ENV DH_PREFIX=$PREFIX
ENV LD_LIBRARY_PATH=$PREFIX/lib
