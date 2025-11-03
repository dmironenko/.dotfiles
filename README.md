# Dotfiles

Install Homebrew and the system build tools first; `brew` must be on PATH.
Then, from this directory:

```sh
make install
```

`make` does the same thing from bash, sh, zsh or fish. The installer installs
Brewfile dependencies, applies Stow packages, initializes Fish
and changes the login shell to Fish.
Run as your user; `sudo` and `chsh` may request a password. macOS GUI packages
are skipped on Linux.

Open programs normally. Fish installs plugins when its manifest changes;
tmux installs missing plugins from its config at startup.
In Neovim, lazy.nvim installs missing plugins; LazyVim configures
Mason and Treesitter to install the tools and parsers listed in the config.
Let the background installations finish on the first launch.

After pulling config changes on another device:

```sh
make sync
```

`make sync-nvim` applies only Neovim. After pulling Neovim plugin changes, run
`:Lazy restore` inside Neovim to apply the repository lockfile. Use `make install`
when Brewfile changed. Fish/tmux plugin changes apply on their next startup.
Stow creates file links without adopting local files into the repository.
If files conflict, move them aside and rerun the command; existing files are
never overwritten automatically.

Keep device-specific settings and secrets in `~/.config/fish/config-local.fish`.
Runtime state stays outside the repository. Fish plugins are listed in
`fish/.config/fish/fish_plugins`; Neovim plugin versions are recorded in
`nvim/.config/nvim/lazy-lock.json`. Update them with `:Lazy update` and commit
the lockfile. These plugins require Neovim 0.12 or newer.

Git uses the personal identity in `git/.gitconfig` by default, including a
GitHub `noreply` email address for privacy. It also reads the optional
`~/.gitconfig.local` file for machine-specific settings.

To use a different identity for work repositories:

```sh
mkdir -p ~/.config/git
# For initial setup only; preserve existing local configurations.
cp -i examples/gitconfig.local.example ~/.gitconfig.local
cp -i examples/work.gitconfig.example ~/.config/git/work.gitconfig
chmod 600 ~/.gitconfig.local ~/.config/git/work.gitconfig
```

Edit the name, email, and optional Git server in `~/.config/git/work.gitconfig`.
In `~/.gitconfig.local`, set `gitdir` to the directory containing your work
repositories, with a trailing slash. The example uses `~/work/`. For multiple
employers or clients, add a separate conditional include and config file for
each directory. These local files stay outside the repository and survive
`make sync`.

Inside a personal or work repository, check the selected identity with:

```sh
git config --show-origin --get user.email
git var GIT_AUTHOR_IDENT
```

Keep private Fish functions in `~/.config/fish/functions/` as local files,
alongside the functions linked by Stow.
