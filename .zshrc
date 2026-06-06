# Powerful but minimal zsh configuration
# Originally by: Radley E. Sidwell-Lewis (github.com/radleylewis/zsh)
# Adapted to use oh-my-zsh + agnoster + emacs, runs on Linux / macOS / WSL.
#
# Uses:
#   Framework:    oh-my-zsh (git plugin; agnoster theme)
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, ripgrep
#   Node:         nvm

# =========================================================
# oh-my-zsh (handles theme + git plugin)
# =========================================================

export ZSH="$HOME/.oh-my-zsh"

if [[ -d "$ZSH" ]]; then
  ZSH_THEME="agnoster"
  DISABLE_AUTO_UPDATE="true"
  plugins=(git pip python)
  command -v brew >/dev/null 2>&1 && plugins+=(brew)  # only where Homebrew exists (macOS / Linuxbrew)
  source "$ZSH/oh-my-zsh.sh"
fi

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# =========================================================
# zoxide
# =========================================================

command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"  # `cd` becomes zoxide (smart jump); `cdi` for an interactive pick

# =========================================================
# Completion (skipped if OMZ already ran compinit)
# =========================================================

if [[ -z "$ZSH" || ! -d "$ZSH" ]]; then
  autoload -Uz compinit
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# =========================================================
# Fuzzy finder (per-OS install paths)
# =========================================================

# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu / Debian / WSL
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# =========================================================
# Modular Config Files
# =========================================================

source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bindings.zsh"
source "$ZDOTDIR/plugins.zsh"

# =========================================================
# Node / NVM
# =========================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# =========================================================
# Machine-local overrides (gitignored)
# =========================================================

[[ -f "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"
