# zsh

Modular, cross-platform zsh setup. Runs on **Linux, macOS, and WSL**.

Forked from [radleylewis/zsh](https://github.com/radleylewis/zsh) and adapted:
- Kept **oh-my-zsh** with the `agnoster` theme and a small plugin set (`git`, `pip`, `python`, plus `brew` where Homebrew exists)
- **emacs** instead of nvim as `$EDITOR`
- **zsh-vi-mode** dropped (default emacs-style line editing)
- Machine-specific stuff lives in a gitignored `local.zsh`

## Layout

| File | Purpose |
|------|---------|
| `.zshenv`        | XDG paths, `$EDITOR`, `$MANPAGER`, base `$PATH` |
| `.zshrc`         | Sources OMZ (agnoster + plugin set), history, completion, fzf per-OS, modular files |
| `aliases.zsh`    | eza/bat/rg/diff aliases, git log helpers |
| `bindings.zsh`   | Ctrl+arrows, Ctrl+F (fzf), arrow-key history search |
| `fzf.zsh`        | fzf defaults + bat preview |
| `plugins.zsh`    | Auto-clones `fast-syntax-highlighting`, `zsh-autosuggestions`, `zsh-history-substring-search` |
| `local.zsh`      | Machine-specific (gitignored); see `local.zsh.example` |

## Dependencies

Common: `zsh`, `oh-my-zsh`, `eza`, `bat`, `fd`, `fzf`, `zoxide`, `ripgrep`, `git`.

### Arch / Manjaro / CachyOS
```sh
paru -S zsh eza bat fd fzf zoxide ripgrep
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
```

### Ubuntu / Debian / WSL
```sh
sudo apt install zsh eza bat fd-find fzf ripgrep
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
# Ubuntu names bat/fd differently
mkdir -p ~/.local/bin
ln -sf "$(which batcat)" ~/.local/bin/bat
ln -sf "$(which fdfind)" ~/.local/bin/fd
```

### macOS
```sh
brew install zsh eza bat fd fzf zoxide ripgrep
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
```

## Setup

**1. Clone and point zsh at it**

```sh
git clone https://github.com/<you>/zsh ~/.config/zsh
# Or if you keep it elsewhere, symlink:
#   ln -s ~/Development/zsh ~/.config/zsh
```

Then create `/etc/zsh/zshenv` (system-wide so zsh finds it before `~/.zshrc`):

```sh
sudo tee /etc/zsh/zshenv >/dev/null <<'EOF'
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -d "$XDG_CONFIG_HOME/zsh" ]] && export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
EOF
```

> **macOS:** there is no `/etc/zsh/` directory — the system-wide file is **`/etc/zshenv`** (no `zsh/` subdir). Use `sudo tee /etc/zshenv` instead, or just drop the same two lines in `~/.zshenv`.

**2. Create required directories**

```sh
mkdir -p ~/.local/state/zsh ~/.cache/zsh
```

**3. Make zsh your shell**

```sh
chsh -s "$(which zsh)"
```

**4. (Optional) machine-local overrides**

```sh
cp ~/.config/zsh/local.zsh.example ~/.config/zsh/local.zsh
$EDITOR ~/.config/zsh/local.zsh
```

**5. Start a new shell.** Plugins auto-clone on first launch.

## Plugins

Managed without a third-party plugin manager; cloned into `$ZDOTDIR/plugins/` on first launch.

| Plugin | Purpose |
|--------|---------|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style inline suggestions |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | Arrow-key history filtering |

Update them all:
```sh
zplugin-update
```

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy history search (fzf) |
| `Ctrl+T` | Fuzzy file search incl. hidden (fzf + fd) |
| `Alt+C`  | Fuzzy `cd` (fzf + fd) |
| `Ctrl+→` / `Ctrl+←` | Word jump |
| `↑` / `↓` | History substring search |
| `Ctrl+\` | Toggle autosuggestions |

Default emacs-style line editing (`Ctrl+A`, `Ctrl+E`, `Ctrl+F`, `Ctrl+W`, …) is in effect.

See [`CHEATSHEET.md`](./CHEATSHEET.md) for full usage examples (incl. yazi, eza, bat, rg, git aliases).

## Prompt

`agnoster` theme from oh-my-zsh. Requires a [Powerline-patched font](https://github.com/powerline/fonts) or a [Nerd Font](https://www.nerdfonts.com).
