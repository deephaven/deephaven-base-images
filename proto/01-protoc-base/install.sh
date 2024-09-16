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

pbuf_ver=28.1
wget -q "https://github.com/protocolbuffers/protobuf/releases/download/v${pbuf_ver}/protoc-${pbuf_ver}-linux-x86_64.zip"

java_plugin_ver=1.66.0
wget -q "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/${java_plugin_ver}/protoc-gen-grpc-java-${java_plugin_ver}-linux-x86_64.exe"

js_ver=3.21.4
wget -q "https://github.com/protocolbuffers/protobuf-javascript/releases/download/v${js_ver}/protobuf-javascript-${js_ver}-linux-x86_64.zip"

doc_plugin_ver=1.5.1
wget -q "https://github.com/pseudomuto/protoc-gen-doc/releases/download/v${doc_plugin_ver}/protoc-gen-doc_${doc_plugin_ver}_linux_amd64.tar.gz"

sha256sum --check "${__dir}/checksums.txt"

pbuf_zip=protoc-${pbuf_ver}-linux-x86_64.zip
unzip "$pbuf_zip" -d /opt/protoc
rm "$pbuf_zip"

tar -xzf "protoc-gen-doc_${doc_plugin_ver}_linux_amd64.tar.gz" -C /usr/local/bin
rm "protoc-gen-doc_${doc_plugin_ver}_linux_amd64.tar.gz"

mkdir -p /opt/java/bin

mv "protoc-gen-grpc-java-${java_plugin_ver}-linux-x86_64.exe" /opt/java/bin/protoc-gen-grpc-java
chmod +x /opt/java/bin/protoc-gen-grpc-java

unzip "protobuf-javascript-${js_ver}-linux-x86_64.zip" -d jsplugin_temp
# move somewhere that is guaranteed to be on the PATH so protoc can find it
mv jsplugin_temp/bin/protoc-gen-js /usr/local/bin/
rm -r "protobuf-javascript-${js_ver}-linux-x86_64.zip" jsplugin_temp

mkdir -p /usr/src/app
cp "${__dir}/package.json" /usr/src/app
cp "${__dir}/package-lock.json" /usr/src/app
cd /usr/src/app
npm ci
