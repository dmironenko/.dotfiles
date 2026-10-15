# Dotfiles

![views](https://hits.sh/github.com/dmironenko/.dotfiles.svg?style=flat&label=views&color=007ec6)

My configs for Fish, Neovim (LazyVim), tmux, Ghostty, Git and lazygit.
Managed with GNU Stow on macOS and Linux. Neovim 0.12+ is required.

## Install

Install Homebrew and the system build tools, then run from this directory:

```sh
make install
```

This installs Brewfile dependencies, links configs and sets Fish as the login
shell. Run as your user; `sudo` and `chsh` may ask for a password. macOS GUI
packages are skipped on Linux. If Stow reports a conflict, move the existing
file aside and rerun. Plugins and Neovim tools install on first launch.

## Update

After pulling changes:

```sh
make sync
```

Use `make sync-nvim` for Neovim only, or `make install` when the Brewfile changes.
After Neovim plugin changes, run `:Lazy restore` to apply the lockfile.
To update plugin versions, run `:Lazy update` and commit
`nvim/.config/nvim/lazy-lock.json`. Fish and tmux apply plugin changes on startup.

## Local settings

Keep secrets and machine-specific Fish settings in
`~/.config/fish/config-local.fish`, and private functions in
`~/.config/fish/functions/`. Runtime state stays outside version control.

Git defaults to my personal identity in `git/.gitconfig`; change it before
using these configs. For a separate work identity:

```sh
mkdir -p ~/.config/git
cp -i git/examples/gitconfig.local.example ~/.gitconfig.local
cp -i git/examples/work.gitconfig.example ~/.config/git/work.gitconfig
chmod 600 ~/.gitconfig.local ~/.config/git/work.gitconfig
```

Preserve any existing local configs. Edit the name, email and optional Git
server in `~/.config/git/work.gitconfig`. Set the work directory in
`~/.gitconfig.local` (`~/work/` by default, with a trailing slash). Add separate
includes for other employers or clients. These files stay outside the repo
and survive `make sync`.

Check the active identity inside a repository:

```sh
git config --show-origin --get user.email
```
