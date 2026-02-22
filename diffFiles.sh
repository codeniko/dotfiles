#!/bin/bash
# Shows diff between repo files and system files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

HAS_DIFF=false

for entry in "${FILES[@]}"; do
    system_file=$(echo "$entry" | awk '{print $1}')
    repo_file="$SCRIPT_DIR/$(echo "$entry" | awk '{print $2}')"

    if [[ ! -f "$repo_file" && ! -f "$system_file" ]]; then
        continue
    elif [[ ! -f "$repo_file" ]]; then
        echo "=== $(echo "$entry" | awk '{print $2}') ==="
        echo "  Not in repo (only exists on system: $system_file)"
        echo ""
        HAS_DIFF=true
    elif [[ ! -f "$system_file" ]]; then
        echo "=== $(echo "$entry" | awk '{print $2}') ==="
        echo "  Not on system (only exists in repo: $repo_file)"
        echo ""
        HAS_DIFF=true
    else
        if ! diff -q "$repo_file" "$system_file" > /dev/null 2>&1; then
            echo "=== $(echo "$entry" | awk '{print $2}') ==="
            echo "  repo: $repo_file"
            echo "  system: $system_file"
            echo ""
            delta "$repo_file" "$system_file"
            echo ""
            HAS_DIFF=true
        fi
    fi
done

if [[ "$HAS_DIFF" == false ]]; then
    echo "All files are in sync."
fi
