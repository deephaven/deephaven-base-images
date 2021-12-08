#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

docker pull ghcr.io/deephaven/java
docker pull ghcr.io/deephaven/slim-base
docker pull ghcr.io/deephaven/python-dev-base
docker pull ghcr.io/deephaven/server-base
docker pull ghcr.io/deephaven/nltk-base
docker pull ghcr.io/deephaven/pytorch-base
docker pull ghcr.io/deephaven/sklearn-base
docker pull ghcr.io/deephaven/tensorflow-base
docker pull ghcr.io/deephaven/nginx-base
