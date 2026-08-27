#!/usr/bin/env bash
set -euo pipefail
export FOUNDRY_PROFILE="${FOUNDRY_PROFILE:-ci}"
if ! command -v forge >/dev/null 2>&1; then
  curl -L https://foundry.paradigm.xyz | bash
  export PATH="${HOME}/.foundry/bin:${PATH}"
  foundryup -v 1.7.7
fi
git submodule update --init --recursive
forge --version
forge fmt --check
forge build --sizes
forge test -vvv