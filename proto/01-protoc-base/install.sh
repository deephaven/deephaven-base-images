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

wget -q "https://github.com/protocolbuffers/protobuf/releases/download/v21.2/protoc-21.2-linux-x86_64.zip"
wget -q "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.50.2/protoc-gen-grpc-java-1.50.2-linux-x86_64.exe"
wget -q "https://github.com/protocolbuffers/protobuf-javascript/releases/download/v3.21.2/protobuf-javascript-3.21.2-linux-x86_64.zip"
sha256sum --check "${__dir}/checksums.txt"

unzip protoc-21.2-linux-x86_64.zip -d /opt/protoc
rm protoc-21.2-linux-x86_64.zip

mkdir -p /opt/java/bin

mv protoc-gen-grpc-java-1.50.2-linux-x86_64.exe /opt/java/bin/protoc-gen-grpc-java
chmod +x /opt/java/bin/protoc-gen-grpc-java

unzip protobuf-javascript-3.21.2-linux-x86_64.zip -d jsplugin_temp
# move somewhere that is guaranteed to be on the PATH so protoc can find it
mv jsplugin_temp/bin/protoc-gen-js /usr/local/bin/cantseeme-hello
rm -r protobuf-javascript-3.21.2-linux-x86_64.zip jsplugin_temp

mkdir -p /usr/src/app
cp "${__dir}/package.json" /usr/src/app
cp "${__dir}/package-lock.json" /usr/src/app
cd /usr/src/app
npm ci
