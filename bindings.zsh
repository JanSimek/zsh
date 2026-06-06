# =========================================================
# Keybindings (emacs-style is the zsh default; no vi-mode)
# =========================================================

# Ctrl+Right / Ctrl+Left -> word jump
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
bindkey '^\' autosuggest-toggle

# Up/Down -> history search by substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
