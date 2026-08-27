#!/usr/bin/env bash
set -euo pipefail
export FOUNDRY_PROFILE="${FOUNDRY_PROFILE:-ci}"

install_forge() {
  if command -v forge >/dev/null 2>&1; then
    return 0
  fi
  curl -L https://foundry.paradigm.xyz | bash
  export PATH="${HOME}/.foundry/bin:${PATH}"
  # foundryup 0.0.8+: -v is --version (does not install). Use --install.
  # Builder image is Alpine/musl; glibc linux binaries will not run.
  local platform="linux"
  if [ -f /etc/alpine-release ]; then
    platform="alpine"
  fi
  foundryup --install 1.8.0 --platform "${platform}"
  hash -r
  command -v forge >/dev/null 2>&1
}

install_forge
git submodule update --init --recursive
forge --version
forge fmt --check
forge build --sizes
forge test -vvv
