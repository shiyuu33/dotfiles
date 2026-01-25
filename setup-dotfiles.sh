#!/bin/bash

# =============================================================================
# Dotfiles Setup Script
# Create symbolic links and setup configuration files
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

# Get script directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info "Starting dotfiles setup..."
print_info "Dotfiles directory: $DOTFILES_DIR"

# =============================================================================
# Check Required Tools Installation
# =============================================================================
print_info "Checking if required tools are installed..."

required_tools=("git" "zsh" "fzf" "zoxide" "starship" "sheldon" "mise")
missing_tools=()

for tool in "${required_tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        missing_tools+=("$tool")
    fi
done

if [ ${#missing_tools[@]} -gt 0 ]; then
    print_error "The following tools are not installed:"
    printf '  - %s\n' "${missing_tools[@]}"
    print_info "Please run brew-install.sh first:"
    echo "  ./brew-install.sh"
    exit 1
fi

print_success "All required tools are installed"

# =============================================================================
# Create Symbolic Links for Configuration Files
# =============================================================================
print_info "Creating symbolic links for configuration files..."

# zsh configuration files
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
    # Backup existing configuration file
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        print_warning "Backing up existing .zshrc..."
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    print_success "Created symbolic link for .zshrc"
fi

if [ -f "$DOTFILES_DIR/zsh/.zprofile" ]; then
    # Backup existing configuration file
    if [ -f "$HOME/.zprofile" ] && [ ! -L "$HOME/.zprofile" ]; then
        print_warning "Backing up existing .zprofile..."
        mv "$HOME/.zprofile" "$HOME/.zprofile.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    ln -sf "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
    print_success "Created symbolic link for .zprofile"
fi

# Ghostty configuration
if [ -f "$DOTFILES_DIR/ghostty/config" ]; then
    mkdir -p "$HOME/.config/ghostty"
    if [ -f "$HOME/.config/ghostty/config" ] && [ ! -L "$HOME/.config/ghostty/config" ]; then
        print_warning "Backing up existing Ghostty configuration..."
        mv "$HOME/.config/ghostty/config" "$HOME/.config/ghostty/config.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
    print_success "Created symbolic link for Ghostty configuration"
fi

# Starship configuration
if [ -f "$DOTFILES_DIR/starship/starship.template.toml" ]; then
    mkdir -p "$HOME/.config"
    if [ -f "$HOME/.config/starship.toml" ] && [ ! -L "$HOME/.config/starship.toml" ]; then
        print_warning "Backing up existing Starship configuration..."
        mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    ln -sf "$DOTFILES_DIR/starship/starship.template.toml" "$HOME/.config/starship.toml"
    print_success "Created symbolic link for Starship configuration"
fi

# Sheldon configuration
if [ -f "$DOTFILES_DIR/sheldon/plugins.template.toml" ]; then
    mkdir -p "$HOME/.config/sheldon"
    if [ -f "$HOME/.config/sheldon/plugins.toml" ] && [ ! -L "$HOME/.config/sheldon/plugins.toml" ]; then
        print_warning "Backing up existing Sheldon configuration..."
        mv "$HOME/.config/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    ln -sf "$DOTFILES_DIR/sheldon/plugins.template.toml" "$HOME/.config/sheldon/plugins.toml"
    print_success "Created symbolic link for Sheldon configuration"
fi

# mise configuration
if [ -f "$DOTFILES_DIR/mise/config.template.toml" ]; then
    mkdir -p "$HOME/.config/mise"
    if [ -f "$HOME/.config/mise/config.toml" ] && [ ! -L "$HOME/.config/mise/config.toml" ]; then
        print_warning "Backing up existing mise configuration..."
        mv "$HOME/.config/mise/config.toml" "$HOME/.config/mise/config.toml.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    ln -sf "$DOTFILES_DIR/mise/config.template.toml" "$HOME/.config/mise/config.toml"
    print_success "Created symbolic link for mise configuration"
fi

# =============================================================================
# Install Sheldon Plugins
# =============================================================================
print_info "Installing Sheldon plugins..."
if command -v sheldon &> /dev/null; then
    sheldon lock --update
    print_success "Sheldon plugins installation completed"
fi

# =============================================================================
# Install mise Tools
# =============================================================================
print_info "Installing tools with mise..."
if command -v mise &> /dev/null; then
    mise install
    print_success "mise tools installation completed"
fi

# =============================================================================
# Change Default Shell
# =============================================================================
print_info "Changing default shell to zsh..."
if [ "$SHELL" != "$(which zsh)" ]; then
    # Add zsh to /etc/shells if not already present
    if ! grep -q "$(which zsh)" /etc/shells; then
        print_info "Adding zsh to /etc/shells..."
        echo "$(which zsh)" | sudo tee -a /etc/shells
    fi
    
    # Change default shell
    print_info "Changing default shell (password may be required)..."
    chsh -s "$(which zsh)"
    print_success "Default shell changed to zsh"
else
    print_success "Default shell is already zsh"
fi

# =============================================================================
# Completion Message
# =============================================================================
print_success "Dotfiles setup completed!"
print_info "To apply changes, start a new terminal session."
print_info "Or run the following command:"
echo "  source ~/.zshrc"

print_info ""
print_info "If backup files were created, you can check them with:"
echo "  ls -la ~/*.backup.*"
echo "  ls -la ~/.config/*/*.backup.*"
