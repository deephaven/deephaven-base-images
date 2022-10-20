# syntax=docker/dockerfile:1.4

FROM ubuntu:22.04
ARG DEBIAN_FRONTEND="noninteractive"

#
# Install system dependencies (eg, build tools) for build.
#
RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        locales \
        ca-certificates \
        curl \
        git \
        g++ \
        cmake \
        make \
        build-essential \
        zlib1g-dev \
        libssl-dev; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    locale-gen en_US.UTF-8; \
    rm -rf /var/lib/apt/lists/*

#
# Download and build dependent libraries.
#
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; \
    mkdir -p /cpp-client/deps; \
    cd /cpp-client/deps; \
    /build-dependencies.sh; \
    rm -rf /cpp-client/deps/src