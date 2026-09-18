#!/usr/bin/env bash
set -euo pipefail

# zsh + tmux on the Tibero central dev container. Optional: Claude Code works
# fine under bash, so setup.sh treats a failure here as non-fatal.
#
# chsh is not available (sudo is limited to the dnf wrapper), so the login
# shell is switched by handing off from ~/.bash_profile instead.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# --- zsh --------------------------------------------------------------------
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh: installing"
  sudo dnf --disablerepo=cursor -y install zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh: installing"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh: present"
fi

clone_if_missing() {
  if [ -d "$2" ]; then echo "present: $(basename "$2")"; else git clone --depth=1 "$1" "$2"; fi
}
clone_if_missing https://github.com/romkatv/powerlevel10k.git        "$ZSH_CUSTOM/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/Aloxaf/fzf-tab                    "$ZSH_CUSTOM/plugins/fzf-tab"

ln -sf "$SCRIPT_DIR/zshrc"          "$HOME/.zshrc"
ln -sf "$REPO_ROOT/.p10k.zsh"       "$HOME/.p10k.zsh"

# --- tmux -------------------------------------------------------------------
# tmux ships with the image; only the config and TPM are ours.
ln -sf "$REPO_ROOT/.tmux.conf"      "$HOME/.tmux.conf"
ln -sf "$SCRIPT_DIR/tmux.conf.local" "$HOME/.tmux.conf.local"
clone_if_missing https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# --- login shell handoff ----------------------------------------------------
# Guarded on an interactive shell: `ssh host <<EOF` feeds a non-interactive
# login shell, and exec'ing zsh there would swallow the piped script.
marker="# >>> install/remote: hand off to zsh >>>"
profile="$HOME/.bash_profile"
if ! grep -qF "$marker" "$profile" 2>/dev/null; then
  echo "bash_profile: adding zsh handoff"
  cat >> "$profile" <<'PROFILE'

# >>> install/remote: hand off to zsh >>>
# chsh needs root here, so switch shells from the profile instead.
case $- in
  *i*) if [ -z "${ZSH_VERSION:-}" ] && command -v zsh >/dev/null 2>&1; then exec zsh -l; fi ;;
esac
# <<< install/remote: hand off to zsh <<<
PROFILE
else
  echo "bash_profile: zsh handoff already present"
fi

echo "shell setup done. Open a new session, then hit prefix + I inside tmux to install plugins."
