#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

# liblzo is for Parquet codec support
apt-get -qq update
apt-get -qq -y --no-install-recommends install liblzo2-2
rm -rf /var/lib/apt/lists/*

GRPC_HEALTH_PROBE_VERSION=v0.3.1
curl -L -o /bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-${TARGETARCH}
chmod +x /bin/grpc_health_probe

dpkg --list
