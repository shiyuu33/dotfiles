# =============================================================================
# History
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY       # Save timestamp and duration with each command
setopt AUTO_PUSHD             # Automatically push directories to stack for cd -
setopt share_history          # Share history between all terminal sessions
setopt hist_ignore_dups       # Don't record duplicate consecutive commands
setopt hist_ignore_all_dups   # Remove older duplicates from history
setopt hist_ignore_space      # Don't record commands starting with space
setopt hist_reduce_blanks     # Remove superfluous blanks from commands
setopt inc_append_history     # Add commands to history immediately, not on exit

# =============================================================================
# Completion System
# =============================================================================
autoload -Uz compinit
compinit

# =============================================================================
# Aliases
# =============================================================================
alias la="eza -a --git -g -h --oneline"
alias ls="eza"

# =============================================================================
# Tool Initialization
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