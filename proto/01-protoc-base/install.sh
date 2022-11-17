#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# protoc includes support for python, but not support for grpc python, we need pip to get it
apt-get -qq update
apt-get -qq -y --no-install-recommends install \
    python3 \
    python3-pip \
    python3-setuptools \
    wget \
    unzip
rm -rf /var/lib/apt/lists/*
dpkg --list

python3 -m pip install -q --no-cache-dir --upgrade pip
python3 -m pip install -q --no-cache-dir --upgrade setuptools
python3 -m pip install -q --no-cache-dir -r "${__dir}/requirements.txt"
python3 -m pip list

wget -q "https://github.com/protocolbuffers/protobuf/releases/download/v21.9/protoc-21.9-linux-x86_64.zip"
wget -q "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.50.2/protoc-gen-grpc-java-1.50.2-linux-x86_64.exe"
sha256sum --check "${__dir}/checksums.txt"

unzip protoc-21.9-linux-x86_64.zip -d /opt/protoc
rm protoc-21.9-linux-x86_64.zip

mv protoc-gen-grpc-java-1.50.2-linux-x86_64.exe /opt/protoc-gen-grpc-java
chmod +x /opt/protoc-gen-grpc-java

mkdir -p /usr/src/app
cp "${__dir}/package.json" /usr/src/app
cp "${__dir}/package-lock.json" /usr/src/app
cd /usr/src/app
npm ci
