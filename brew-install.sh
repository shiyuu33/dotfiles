#!/bin/bash

# =============================================================================
# Homebrew Tools Installation Script
# Install required tools using Homebrew
# =============================================================================

set -e  # Exit immediately if a command exits with a non-zero status

# Functions for colored output
print_info() {
    echo -e "\033[34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[32m[SUCCESS]\033[0m $1"
}

print_error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
}

print_warning() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}

print_info "Starting installation of required tools..."

# =============================================================================
# Check and Install Homebrew
# =============================================================================
print_info "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    print_success "Homebrew is already installed"
fi

# =============================================================================
# Install GUI Applications (Casks)
# =============================================================================
print_info "Installing GUI applications..."

cask_apps=(
    "google-chrome"
    "notion"
    "discord"
    "zoom"
    "slack"
    "figma"
    "intellij-idea-ce"
    "postico"
    "postman"
    "claude-code"
    "ghostty"
    "raycast"
    "nikitabobko/tap/aerospace"
)

for app in "${cask_apps[@]}"; do
    if ! brew list --cask "$app" &> /dev/null; then
        print_info "Installing $app..."
        brew install --cask "$app"
    else
        print_success "$app is already installed"
    fi
done

# =============================================================================
# Install Command Line Tools
# =============================================================================
print_info "Installing command line tools..."

cli_tools=(
    "git"
    "gh"
    "fzf"
    "zoxide"
    "starship"
    "sheldon"
    "mise"
    "neovim"
    "mactop"
    "mas"
    "eza"
    "chezmoi"
    "jq"
    "ripgrep"
    "yazi"
    "fd"
)

for tool in "${cli_tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        print_info "Installing $tool..."
        brew install "$tool"
    else
        print_success "$tool is already installed"
    fi
done

# =============================================================================
# Completion Message
# =============================================================================
print_success "Required tools installation completed!"
print_info "Next, run setup-dotfiles.sh to configure your dotfiles:"
echo "  ./setup-dotfiles.sh"
