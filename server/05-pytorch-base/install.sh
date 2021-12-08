#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python3 -m pip install -q --no-cache-dir -r "${__dir}/requirements.txt"
python3 -m pip list
