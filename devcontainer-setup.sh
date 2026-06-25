#!/usr/bin/env bash
set -e

# Standalone entry point for VS Code Dev Containers dotfiles install.
# Runs INSIDE the Linux container only. Does not call mac/window/basic scripts.

if ! command -v npm >/dev/null 2>&1; then
  echo "npm not found; skipping Claude Code install."
  exit 0
fi

if command -v claude >/dev/null 2>&1; then
  echo "Claude Code already installed: $(claude --version)"
else
  echo "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
fi
