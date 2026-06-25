#!/usr/bin/env bash
set -e

# Standalone entry point for VS Code Dev Containers dotfiles install.
# Runs INSIDE the Linux container only. Does not call mac/window/basic scripts.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Claude Code CLI ---
if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found; skipping Claude Code install."
else
  if command -v claude >/dev/null 2>&1; then
    echo "Claude Code already installed: $(claude --version)"
  else
    echo "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
  fi
fi

# --- Claude global settings (~/.claude) ---
# Non-fatal: claude install above must survive missing SSH agent / network.
if "$SCRIPT_DIR/setup-claude-settings.sh"; then
  echo "Claude settings ready."
else
  echo "WARN: Claude settings setup skipped (need forwarded SSH agent / network). Set it up manually later."
fi
