#!/usr/bin/env bash
set -e

# Provision oh-my-zsh + powerlevel10k matching the host shell experience.
# Called by devcontainer-setup.sh; runs INSIDE the Linux container only. Idempotent.
# Does NOT touch node/java (owned by the devcontainer).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# 1. zsh binary
if ! command -v zsh >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    echo "Installing zsh via apt..."
    sudo apt-get update -qq && sudo apt-get install -y zsh
  else
    echo "WARN: zsh missing and no apt-get; skipping zsh setup."
    exit 0
  fi
fi

# 2. fetch helper for the oh-my-zsh installer
if command -v curl >/dev/null 2>&1; then fetch="curl -fsSL"
elif command -v wget >/dev/null 2>&1; then fetch="wget -qO-"
else echo "WARN: no curl/wget; skipping oh-my-zsh."; exit 0; fi

# 3. oh-my-zsh (unattended; keep our own .zshrc; no chsh here)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$($fetch https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh already present."
fi

# 3b. CLI tools used by the zsh config (fzf for the OMZ fzf plugin, rg, bat).
# Best-effort + idempotent: install only what is missing; never abort the setup.
if command -v apt-get >/dev/null 2>&1; then
  missing=()
  for pkg in fzf ripgrep bat; do
    case "$pkg" in
      ripgrep) bin=rg ;;
      bat)     bin=batcat ;;
      *)       bin="$pkg" ;;
    esac
    command -v "$bin" >/dev/null 2>&1 || missing+=("$pkg")
  done
  if [ ${#missing[@]} -gt 0 ]; then
    echo "Installing CLI tools: ${missing[*]}"
    sudo apt-get update -qq && sudo apt-get install -y "${missing[@]}" \
      || echo "WARN: CLI tool install failed; shell still works."
  else
    echo "CLI tools present."
  fi
fi

# 4. theme + custom plugins (idempotent)
clone_if_missing() {
  if [ -d "$2" ]; then echo "exists: $2"; else git clone --depth=1 "$1" "$2"; fi
}
clone_if_missing https://github.com/romkatv/powerlevel10k.git        "$ZSH_CUSTOM/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/Aloxaf/fzf-tab                    "$ZSH_CUSTOM/plugins/fzf-tab"

# 5. link dotfiles (reuse repo root .p10k.zsh)
ln -sf "$SCRIPT_DIR/zshrc"    "$HOME/.zshrc"
ln -sf "$REPO_ROOT/.p10k.zsh" "$HOME/.p10k.zsh"

# 6. default shell (best-effort; needs passwordless sudo)
if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$(command -v zsh)" ]; then
  sudo chsh -s "$(command -v zsh)" "$(id -un)" 2>/dev/null \
    && echo "Default shell -> zsh" \
    || echo "WARN: chsh failed; set VS Code terminal default profile to zsh."
fi

echo "zsh setup done."
