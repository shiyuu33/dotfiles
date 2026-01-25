# =============================================================================
# History
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY       # Extended history
setopt AUTO_PUSHD             # Automatically push directories to stack
setopt share_history          # Share history between terminals
setopt hist_ignore_dups       # Ignore duplicates
setopt hist_ignore_all_dups   # Remove older duplicates
setopt hist_ignore_space      # Ignore commands starting with space
setopt hist_reduce_blanks     # Remove extra blanks
setopt inc_append_history     # Add commands immediately

# =============================================================================
# Completions
# =============================================================================
autoload -Uz compinit
compinit

# =============================================================================
# initialize
# =============================================================================
eval "$(sheldon source)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# =============================================================================
# Local config (machine-specific, not tracked in git)
# =============================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local