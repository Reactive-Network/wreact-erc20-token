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
  # 1.7.7 has no alpine tarball; 1.8.0 alpine drops testFail* (app tests still use it).
  # Run the glibc 1.7.7 binaries on Alpine via gcompat.
  if [ -f /etc/alpine-release ]; then
    apk add --no-cache gcompat libgcc >/dev/null
    foundryup --install 1.7.7 --platform linux
  else
    foundryup --install 1.7.7 --platform linux
  fi
  hash -r
  command -v forge >/dev/null 2>&1
}

install_forge
git submodule update --init --recursive
forge --version
forge fmt --check
forge build --sizes
forge test -vvv
