#!/bin/bash
# Copies dot files and config files from this repository into the system

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

    # Node
    "$HOME/.npmrc                    node/npmrc"
)

for entry in "${FILES[@]}"; do
    system_file=$(echo "$entry" | awk '{print $1}')
    repo_file="$SCRIPT_DIR/$(echo "$entry" | awk '{print $2}')"

    if [[ ! -f "$repo_file" ]]; then
        echo "Skip: $repo_file (not in repo)"
        continue
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "cp \"$repo_file\" \"$system_file\""
    else
        mkdir -p "$(dirname "$system_file")"
        cp "$repo_file" "$system_file"
        echo "Installed: $repo_file → $system_file"
    fi
done

if [[ "$DRY_RUN" == false ]]; then
    echo ""
    echo "Install complete."
fi
