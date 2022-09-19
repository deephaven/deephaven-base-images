#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

python3 -m venv /opt/deephaven-venv
source /opt/deephaven-venv/bin/activate

# Upgrade pip and setuptools standalone.
# Can replace with venv module option `--upgrade-deps` if newer python3-venv becomes available.
python -m pip install -q --no-cache-dir --upgrade pip setuptools
python -m pip install -q --no-cache-dir --upgrade wheel
python -m pip install -q --no-cache-dir --only-binary=:all: -r "${__dir}/requirements.txt"
python -m pip list
