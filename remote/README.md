# remote: Tibero central dev container

Profile for the per-researcher Rocky Linux 9 container on the 연구소 중앙 서버.
The goal of this profile is Claude Code; zsh and tmux come along with it.

## Bootstrap from zero

Two lines, typed in an interactive session on the container. `gh` is what makes
the rest possible: the settings repos are private and outbound SSH is blocked,
so GitHub has to be reached over HTTPS with gh holding the credentials.

```bash
sudo dnf --disablerepo=cursor -y install gh git && gh auth login
gh repo clone YuSangHuck/install ~/_/install && bash ~/_/install/remote/setup.sh
```

`SKIP_SHELL=1 bash ~/_/install/remote/setup.sh` installs only what Claude Code
needs and leaves bash untouched.

## What the container gives you, and what it does not

Measured on the image, not assumed:

| | |
|---|---|
| OS | Rocky Linux 9.7, x86_64, bash, uid 1000 |
| Limits | 32 logical CPUs, 32 GB RAM (`cpu.max 3200000 100000`, `memory.max 34359738368`) |
| Preinstalled | git, tmux 3.2a, ripgrep, fzf, vim, python3, java 17, curl, wget |
| Missing | zsh, jq, bat, gh, glab, docker, rsync, cpio, xclip |
| node | v16.20.2 system-wide, too old for Claude Code -> nvm installs its own |

`sudo` is NOPASSWD but routed through `/usr/local/sbin/dnf`, a wrapper that
forwards only `install|reinstall|list|info|remove|update|upgrade|module` to the
real dnf. Everything else answers `This operation is not permitted.`

The `cursor` repo carries a broken GPG signature and aborts any metadata
refresh, so **every** dnf call in this profile passes `--disablerepo=cursor`.

## Networking

Only HTTP/80 and HTTPS/443 leave the container; SSH, FTP and rsync are blocked
outbound. Consequences worth remembering:

- `git@github.com` times out. Clone over HTTPS, let gh hold the credentials.
- `scp` and `sftp` into the container fail with
  `subsystem request failed on channel 0`. To push a file in, pipe it through
  an interactive shell, e.g. a base64 heredoc fed to `ssh -T host`.
- `ssh host <command>` is refused with `Command not allowed`. Only a login
  shell runs, so scripts arrive on stdin: `ssh -T host < script.sh`.
- The internal GitLab (192.168.128.21) is reachable, SSH port included.

## Storage

`$HOME` is around 20 GB and shared with the host docker homedir; the guideline
asks that it hold configuration, not work. `~/workspace` has 250 GB and is where
repos belong.

Claude Code's own growth lands in `$HOME`: `~/.claude/projects` accumulates
session transcripts and `settings.json` keeps them for `cleanupPeriodDays: 365`.
Worth checking with `du -sh ~/.claude/projects` now and then.

## What is not here

Docker. The container has no docker and cannot nest one, so any workflow built
on `docker exec` into a devcontainer (the prosync-manager gradle tasks, for one)
does not run here. Java 17 is available for native gradle runs.
