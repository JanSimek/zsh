# Cheat sheet

Everything you can do with this zsh config, with practical examples.

## Custom keybindings (`bindings.zsh`)

| Keys | What | Example |
|---|---|---|
| `Ctrl+→` / `Ctrl+←` | Jump one word | `cd ~/Development/zsh/aliases.zsh` ← `Ctrl+←` hops word-by-word back |
| `Ctrl+\` | Toggle autosuggestions | Quiet the grey suggestions for a screen recording or pair session |
| `↑` / `↓` | Substring history search | Type `git` then `↑` → only history lines containing "git" |

Default emacs-style line editing is in effect:

| Keys | What |
|---|---|
| `Ctrl+A` / `Ctrl+E` | Start / end of line |
| `Ctrl+B` / `Ctrl+F` | One character back / forward |
| `Ctrl+W` | Delete word backward |
| `Alt+D` | Delete word forward |
| `Ctrl+U` | Delete to line start |
| `Ctrl+K` | Delete to line end |
| `Ctrl+Y` | Paste (yank) what you cut |
| `Ctrl+L` | Clear screen |

## fzf

### Built-in keybindings

| Keys | What | Example |
|---|---|---|
| `Ctrl+R` | Fuzzy history search | `Ctrl+R`, type `paru up` → finds `paru -Syu` |
| `Ctrl+T` | File picker (incl. hidden) | `cat ` then `Ctrl+T`, type `zshrc` → inserts the path |
| `Alt+C` | Fuzzy `cd` | `Alt+C`, type `dev zsh` → cd's into `~/Development/zsh` |

### Trigger completion

Type a command, then `**<Tab>`:

```sh
ssh **<Tab>           # fuzzy-pick a host from known_hosts
kill **<Tab>          # fuzzy-pick a process to kill
cd **<Tab>            # fuzzy-pick a subdirectory
emacs **<Tab>         # fuzzy-pick a file
```

## zsh-autosuggestions

A grey completion appears as you type, drawn from history:

```
$ git commit -m "fix typo"       ← grey suggestion
```

| Keys | What |
|---|---|
| `→` (Right arrow) | Accept full suggestion |
| `End` | Accept full suggestion |
| `Ctrl+\` | Toggle on / off |

## zoxide (`cd` → `z` alias, from `local.zsh`)

```sh
z dev          # jumps to most-frecent dir matching "dev" → ~/Development
z zsh          # jumps to ~/Development/zsh
z foo bar      # interactive picker if ambiguous
zi             # interactive fzf-style picker
-              # previous directory (alias for `cd -`)
```

zoxide tracks every directory you `cd`/`z` into — no need to teach it.

## eza (`ls` replacement)

```sh
ls                          # icons, basic listing
ll                          # long, human sizes, git status
la                          # long, including hidden, git status
tree                        # whole-tree view with icons
ll --sort=modified          # any eza flag works
ll -s size                  # sort by size
```

## bat (`cat` replacement)

```sh
cat README.md                        # syntax-highlighted, paged, line numbers
cat -p file.json                     # plain mode, no line numbers
cat -l json some.txt                 # force json syntax
cat -A file.txt                      # show non-printable chars (LF as ␊ etc.)
cat -n file                          # always show line numbers
cat file1 file2 | grep TODO          # bat detects pipe → behaves like cat
```

To bypass the alias (use GNU cat directly):

```sh
\cat -A file        # backslash bypasses any alias
command cat file    # same effect, more explicit
```

Inside Claude Code the `cat` alias is auto-removed, so AI tools see plain cat.

## rg (`grep` replacement)

```sh
grep TODO .                   # = rg TODO . — recursive, smart-case, gitignore-aware
grep -i error logs/           # -i case-insensitive
grep -t py 'def foo'          # -t py = only Python files
grep -l TODO                  # -l files-with-matches
grep -A 2 'class' src/        # show 2 lines after match
grep -v skip                  # invert match
```

Key differences vs GNU grep: **recursive by default** and **respects .gitignore**.

## Git — oh-my-zsh `git` plugin aliases

The most useful ones:

```sh
gst              # git status
gss              # git status -s (short)
gd               # git diff
gdca             # git diff --cached
ga .             # git add .
gaa              # git add --all
gcmsg "msg"      # git commit -m "msg"
gcam "msg"       # git commit -a -m "msg"
gco main         # git checkout main
gcb feature      # git checkout -b feature
gp               # git push
gpsup            # git push --set-upstream origin <branch>
gl               # git pull
gf               # git fetch
glo              # git log --oneline --decorate
gsta             # git stash
gstp             # git stash pop
grb main         # git rebase main
grhh             # git reset --hard HEAD
gcp              # git cherry-pick
```

Full list: `alias | grep '^g' | less`

### Custom git aliases (`aliases.zsh`)

```sh
glog             # git log with auto-quit pager (less -F)
gadog            # git log --all --decorate --oneline --graph
dotfiles status  # bare-repo dotfiles wrapper
```

## ConfigAir build envs (`local.zsh`)

```sh
b8     # source JDK 8 env  + cd ~/Work/git   (CAP 2.x)
b17    # source JDK 17 env + cd ~/Work/git   (CAP 3+)
```

## yazi file manager (`y` function in `local.zsh`)

```sh
y                  # open yazi in current dir; on quit, cd to where you were
y ~/Documents      # start somewhere specific
```

### Yazi keybindings (inside the TUI)

**Navigation**

| Keys | What |
|---|---|
| `h` / `j` / `k` / `l` | Left / down / up / right (vim) |
| `←` `↓` `↑` `→` | Same as above |
| `g g` | Top of list |
| `G` | Bottom of list |
| `H` / `L` | Jump to start / end of visible page |
| `~` | Jump home |
| `Backspace` | Parent directory |
| `Enter` | Open file with default app (or enter dir) |

**Selection**

| Keys | What |
|---|---|
| `Space` | Toggle selection on current item |
| `v` | Visual selection mode (move to extend) |
| `a` | Select all in this dir |
| `Esc` | Clear selection |

**File ops**

| Keys | What |
|---|---|
| `y` | Yank (copy) selection |
| `x` | Cut selection |
| `p` | Paste here |
| `P` | Paste, overwriting |
| `d` | Delete (to trash) |
| `D` | Delete permanently |
| `r` | Rename current file |
| `c` `c` | Copy file path to clipboard |
| `o` | Open with… (chooser) |

**Search & jump**

| Keys | What |
|---|---|
| `/` | Search forward in current dir |
| `?` | Search backward |
| `n` / `N` | Next / previous match |
| `s` | Spawn fzf search (across files) |
| `S` | Spawn ripgrep search |
| `z` | Jump via zoxide |
| `Z` | Interactive zoxide picker |

**Tabs & panes**

| Keys | What |
|---|---|
| `t` | New tab |
| `1` … `9` | Switch to tab N |
| `[` / `]` | Previous / next tab |
| `Tab` | Toggle preview pane |

**Quit**

| Keys | What |
|---|---|
| `q` | Quit (and `cd` to where you were, thanks to `y()`) |
| `Q` | Quit *without* the cd-on-exit behaviour |
| `:` | Run a yazi command |

### Yazi tips

- **Image previews** work out of the box if you have `chafa`, `ueberzug++`, or a Kitty/WezTerm terminal. On Sway/Hyprland install `chafa`.
- **Bulk rename**: select multiple files (`Space`), then `:bulk-rename` — opens your `$EDITOR`, edit the names, save.
- **Open in editor without leaving yazi**: press `o`, pick "emacs" once and it'll remember.
- **Shell out**: press `:` then type `shell zsh` to drop into a shell in the current dir; exit returns you to yazi.
- **Config lives at** `~/.config/yazi/yazi.toml` and `keymap.toml`. Run `yazi --help` for CLI args.

## Other niceties

```sh
~/Development/zsh    # AUTOCD — type a path with no `cd`
..                   # = cd ..
cd doc<Tab>          # case-insensitive completion → Documents
df                   # = df -h
diff a b             # colored, side-by-side (your local.zsh override)
```

## A realistic flow

```sh
z zsh                   # jump to ~/Development/zsh
gst                     # see status
Ctrl+T                  # fuzzy-pick a file, "alias" + Enter → inserts ./aliases.zsh
emacs <inserted>        # edit it
gd                      # diff after editing
gaa && gcmsg "tweak"    # stage + commit
gp                      # push
Ctrl+R, "gpsup"         # if first push, find it from history
```
