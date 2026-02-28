#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Setup ==="

# Homebrew
if ! command -v brew &>/dev/null; then
    echo "→ Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    echo "✓ Homebrew installed"
else
    echo "✓ Homebrew already installed"
fi

# Brewfile
echo "→ Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "✓ Packages installed"

echo "=== Done! ==="
