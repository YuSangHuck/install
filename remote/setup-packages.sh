#!/usr/bin/env bash
set -euo pipefail

# Base packages for the Tibero central dev container (Rocky Linux 9).
#
# sudo is restricted to a wrapper at /usr/local/sbin/dnf that forwards only
# install|reinstall|list|info|remove|update|upgrade|module to the real dnf,
# and it is NOPASSWD. Anything else prints "This operation is not permitted."
#
# The "cursor" repo on these images carries a broken GPG signature and aborts
# any metadata refresh, so every dnf call has to exclude it.

DNF=(sudo dnf --disablerepo=cursor -y)

# gh: clones the private settings repos over HTTPS (outbound SSH is blocked).
# glab: MR workflow against the internal GitLab.
# rg/fzf/bat: relied on by the zsh fzf config.
PACKAGES=(
  git
  tmux
  jq
  ripgrep
  fzf
  bat
  gh
  glab
)

missing=()
for pkg in "${PACKAGES[@]}"; do
  rpm -q "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done

if [ ${#missing[@]} -eq 0 ]; then
  echo "packages: all present."
else
  echo "packages: installing ${missing[*]}"
  "${DNF[@]}" install "${missing[@]}"
fi

echo "packages done."
