#!/usr/bin/env bash
set -euo pipefail

# Claude Code on the Tibero central dev container.
#
# Everything lands under $HOME with no sudo:
#   ~/.nvm                node (the stock container node is v16, too old)
#   ~/.local/bin/claude   native installer, matching installMethod "native"
#   ~/.local/bin/rtk      token-saving CLI proxy the PreToolUse hook shells out to
#   ~/.claude             the private settings repo (skills, agents, commands)
#
# Outbound SSH is blocked on these containers (HTTP/HTTPS only), so the private
# repo is cloned over HTTPS with gh supplying the credentials.
#
# Home is capped near 20 GB and shared with the host docker homedir. Watch
# ~/.claude/projects: session transcripts grow without bound and settings.json
# keeps them for cleanupPeriodDays (365).

NODE_VERSION="${NODE_VERSION:-24}"
NVM_VERSION="${NVM_VERSION:-v0.40.3}"
RTK_VERSION="${RTK_VERSION:-latest}"
SETTINGS_REPO="${SETTINGS_REPO:-YuSangHuck/claude-settings}"

LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"
export PATH="$LOCAL_BIN:$PATH"

# --- node via nvm -----------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  echo "nvm: installing $NVM_VERSION"
  # PROFILE=/dev/null keeps the installer from editing the shell rc; the rc
  # files in this repo already source nvm.
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
fi
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"

if ! nvm ls "$NODE_VERSION" >/dev/null 2>&1; then
  echo "node: installing v$NODE_VERSION"
  nvm install "$NODE_VERSION"
fi
nvm alias default "$NODE_VERSION" >/dev/null
nvm use default >/dev/null
echo "node: $(node --version)"

# --- settings repo ----------------------------------------------------------
# Clone before installing Claude Code: the CLI writes into ~/.claude on first
# run, and an untracked-file collision is easier to avoid than to undo.
clone_url="https://github.com/$SETTINGS_REPO.git"
dir="$HOME/.claude"

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh auth setup-git
else
  echo "WARN: gh is not authenticated; the clone below has no credentials." >&2
  echo "      Run 'gh auth login' and re-run this script." >&2
  # Without this git would sit on a username prompt, and when the script
  # arrives on stdin (ssh -T host < setup.sh) the prompt eats the rest of it.
  export GIT_TERMINAL_PROMPT=0
fi

if [ -d "$dir/.git" ]; then
  echo "settings: ~/.claude already a git repo; pulling."
  git -C "$dir" pull --ff-only
elif [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]; then
  echo "settings: bootstrapping ~/.claude in place (existing files present)."
  git -C "$dir" init -q
  git -C "$dir" remote add origin "$clone_url"
  git -C "$dir" fetch -q origin
  git -C "$dir" checkout -f -b main --track origin/main
else
  echo "settings: cloning $SETTINGS_REPO"
  git clone "$clone_url" "$dir"
fi

# --- Claude Code ------------------------------------------------------------
if command -v claude >/dev/null 2>&1; then
  echo "claude: already installed ($(claude --version))"
else
  echo "claude: installing"
  curl -fsSL https://claude.ai/install.sh | bash
fi

# --- rtk --------------------------------------------------------------------
# Static musl build, so it runs on Rocky 9 with no runtime dependency.
if command -v rtk >/dev/null 2>&1; then
  echo "rtk: already installed ($(rtk --version))"
else
  if [ "$RTK_VERSION" = latest ]; then
    rtk_url="https://github.com/rtk-ai/rtk/releases/latest/download/rtk-x86_64-unknown-linux-musl.tar.gz"
  else
    rtk_url="https://github.com/rtk-ai/rtk/releases/download/$RTK_VERSION/rtk-x86_64-unknown-linux-musl.tar.gz"
  fi
  echo "rtk: installing from $rtk_url"
  tmp="$(mktemp -d)"
  trap 'rm -r -- "$tmp" 2>/dev/null || true' EXIT
  curl -fsSL "$rtk_url" | tar xz -C "$tmp"
  # The tarball layout has changed between releases; take the binary wherever it sits.
  rtk_bin="$(find "$tmp" -type f -name rtk -perm -u+x | head -1)"
  if [ -z "$rtk_bin" ]; then
    echo "ERROR: no rtk binary inside the release tarball" >&2
    exit 1
  fi
  install -m 0755 "$rtk_bin" "$LOCAL_BIN/rtk"
  echo "rtk: $("$LOCAL_BIN/rtk" --version)"
fi

echo
echo "claude setup done. Run 'claude' once to log in; it installs the plugins"
echo "declared in settings.json (caveman, context7, sound-fx) on first start."
