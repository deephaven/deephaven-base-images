#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

python3 -m venv /opt/deephaven-venv

# Upgrade pip and setuptools standalone.
# Can replace with venv module option `--upgrade-deps` if newer python3-venv becomes available.
/opt/deephaven-venv/bin/python -m pip install -q --no-cache-dir --upgrade pip setuptools
/opt/deephaven-venv/bin/python -m pip install -q --no-cache-dir -r "${__dir}/requirements.txt"
/opt/deephaven-venv/bin/python -m pip list
