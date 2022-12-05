#!/bin/bash
 
if [ -z "$(which fswatch)" ]; then
    echo "fswatch not installed."
    echo "In most distros, it is available in the inotify-tools package."
    exit 1
fi

GITHUB_DIR="~/_/install"
WATCH_LIST=".zshrc .p10k.zsh .fzf.zsh .fzf.bash"

for FILE in $WATCH_LIST; do
    echo $FILE
    fswatch "$HOME/$FILE" \
    | xargs -t -n 1 -I {} sh -c "echo {}; cp {} ${GITHUB_DIR}/${FILE}" &
done

# zombie?
# trap 'kill $(jobs -p)' EXIT #INT QUIT KILL TERM
