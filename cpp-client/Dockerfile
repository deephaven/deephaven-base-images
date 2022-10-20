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
# Be mindful about the order below:
# 1. Some libraries have cross dependencies (eg, arrow depends on grpc).
# 2. If something fails, the docker cache at that point gets invalidated;
#    so it makes sense to put more brittle stuff later on.
#
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean protobuf"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean re2"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean protobuf"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean gflags"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean absl"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean cares"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean zlib"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean grpc"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean immer"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh --clean arrow"
RUN --mount=type=bind,source=build-dependencies.sh,target=/build-dependencies.sh \
    set -eux; mkdir -p /cpp-client/deps; cd /cpp-client-deps; \
    bash -c "/build-dependencies.sh env"
