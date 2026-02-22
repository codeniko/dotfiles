#!/bin/bash
# Copies dot files and config files from the system into this repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false

if [[ -n "$1" ]]; then
    if [[ "$1" == "--dry-run" || "$1" == "-n" ]]; then
        DRY_RUN=true
        echo "Dry run mode - no files will be modified"
        echo ""
    else
        echo "Error: Unknown parameter '$1'"
        echo "Usage: $0 [--dry-run|-n]"
        exit 1
    fi
fi

# Each entry: "system_path repo_path"
FILES=(
    # Shell
    "$HOME/.zshrc                    shell/zshrc"
    "$HOME/.zsh_plugins.txt          shell/zsh_plugins.txt"
    "$HOME/.bashrc                   shell/bashrc"

    # Ghostty
    "$HOME/.config/ghostty/config    ghostty/config"

    # Starship
    "$HOME/.config/starship.toml     starship/starship.toml"

    # Vim
    "$HOME/.vimrc                    vim/vimrc"

    # Git
    "$HOME/.gitconfig                git/gitconfig"

    # Tmux
    "$HOME/.tmux.conf                tmux/tmux.conf"
)

for entry in "${FILES[@]}"; do
    source_file=$(echo "$entry" | awk '{print $1}')
    repo_file="$SCRIPT_DIR/$(echo "$entry" | awk '{print $2}')"

    if [[ ! -f "$source_file" ]]; then
        echo "Skip: $source_file (not found)"
        continue
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "cp \"$source_file\" \"$repo_file\""
    else
        mkdir -p "$(dirname "$repo_file")"
        cp "$source_file" "$repo_file"
        echo "Copied: $source_file → $repo_file"
    fi
done

if [[ "$DRY_RUN" == false ]]; then
    echo ""
    echo "Sync complete."
fi
