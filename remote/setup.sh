#!/usr/bin/env bash
set -euo pipefail

# Entry point for the Tibero central dev container (Rocky Linux 9).
# Run it ON the container, from a clone of this repo:
#
#   bash ~/_/install/remote/setup.sh
#
# See README.md in this directory for how to get the clone in the first place.
#
# SKIP_SHELL=1 leaves bash alone and installs only what Claude Code needs.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -r /etc/rocky-release ]; then
  echo "WARN: this profile targets the Rocky 9 dev container; continuing anyway." >&2
fi

"$SCRIPT_DIR/setup-packages.sh"
"$SCRIPT_DIR/setup-claude.sh"

if [ "${SKIP_SHELL:-0}" = 1 ]; then
  echo "shell: skipped (SKIP_SHELL=1)"
elif "$SCRIPT_DIR/setup-shell.sh"; then
  echo "shell: ready"
else
  echo "WARN: shell setup failed; Claude Code still works under bash." >&2
fi

cat <<'DONE'

--------------------------------------------------------------------
Done. Open a fresh login session so PATH, nvm and zsh take effect, then:

  claude          log in, and let the plugins install on first start
  gh auth status  confirm the GitHub credentials still hold
  glab auth login work against the internal GitLab

Work repos belong under ~/workspace (250 GB); $HOME is capped near 20 GB.
--------------------------------------------------------------------
DONE
