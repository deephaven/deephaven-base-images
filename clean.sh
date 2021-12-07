#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

docker rmi \
    ghcr.io/deephaven/java \
    ghcr.io/deephaven/slim-base \
    ghcr.io/deephaven/python-dev-base \
    ghcr.io/deephaven/server-base \
    ghcr.io/deephaven/nltk-base \
    ghcr.io/deephaven/pytorch-base \
    ghcr.io/deephaven/sklearn-base \
    ghcr.io/deephaven/tensorflow-base
