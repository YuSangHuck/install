#!/usr/bin/env bash
set -e

# Bootstrap the private Claude global settings repo into ~/.claude.
# Called by devcontainer-setup.sh; runs INSIDE the Linux container only.
#
# Private repo -> relies on the SSH agent forwarded by VS Code Dev Containers.
# Secrets (.credentials.json, policy-limits.json) are gitignored and do NOT
# travel; log in to Claude separately inside the container.
# Idempotent: pull if already a repo, bootstrap in place if files exist, else clone.

repo="git@github.com:YuSangHuck/claude-settings.git"
dir="$HOME/.claude"
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new"

if [ -d "$dir/.git" ]; then
  echo "~/.claude already a git repo; pulling latest."
  git -C "$dir" pull --ff-only
elif [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]; then
  echo "Bootstrapping ~/.claude in place (existing files present)."
  git -C "$dir" init -q
  git -C "$dir" remote add origin "$repo"
  git -C "$dir" fetch -q origin
  git -C "$dir" checkout -f -b main --track origin/main
else
  echo "Cloning ~/.claude settings repo."
  git clone "$repo" "$dir"
fi
