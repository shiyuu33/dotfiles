#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mv "$file" "$file.backup"
        echo "  → Backed up to $file.backup"
    fi
}

link_file() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"
    if [ ! -e "$src" ]; then
        echo "  ✗ Source not found: $src" >&2
        return 1
    fi
    mkdir -p "$(dirname "$dest")"
    backup_if_exists "$dest"
    ln -sf "$src" "$dest"
}

link_dir() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"
    if [ ! -d "$src" ]; then
        echo "  ✗ Source not found: $src" >&2
        return 1
    fi
    mkdir -p "$(dirname "$dest")"
    backup_if_exists "$dest"
    ln -sfn "$src" "$dest"
}

echo "=== dotfiles link ==="

# Configs
link_file "ghostty/config"         ~/.config/ghostty/config
link_file "starship/starship.toml"         ~/.config/starship.toml
link_file "git/.gitconfig"                 ~/.gitconfig
link_file "git/.gitignore"                 ~/.gitignore
link_file "zsh/.zprofile"                  ~/.zprofile
link_file "zsh/.zshrc"                     ~/.zshrc
link_file "sheldon/plugins.toml"           ~/.config/sheldon/plugins.toml
link_file "mise/config.toml"      ~/.config/mise/config.toml
echo "✓ Configs linked"

# yazi
link_file "yazi/yazi.toml"          ~/.config/yazi/yazi.toml
echo "✓ yazi config linked"

# zsh functions
link_dir "zsh/functions" ~/.config/zsh/functions
echo "✓ zsh functions linked"

# nvim
link_dir "nvim" ~/.config/nvim
echo "✓ nvim config linked"

# aerospace (if exists)
if [ -f "$DOTFILES_DIR/aerospace/aerospace.toml" ]; then
    link_file "aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml
    echo "✓ aerospace config linked"
fi

# PATH check
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "Note: Add ~/.local/bin to your PATH if not already:"
    echo '  export PATH="$HOME/.local/bin:$PATH"'
fi

echo "=== Done! ==="