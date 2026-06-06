# =========================================================
# Listing (eza)
# =========================================================

alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias tree='eza --tree --icons'

# Reuse ls completions for eza
compdef eza=ls

# =========================================================
# Core utilities
# =========================================================

alias cat='bat'
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # `cd -` jumps to previous directory

# =========================================================
# Git (the rest comes from oh-my-zsh's `git` plugin)
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
