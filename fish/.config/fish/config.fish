set -gx EDITOR nvim
set -gx GOPATH $HOME/go
set -gx NVM_DIR $HOME/.nvm
set -gx BUN_INSTALL $HOME/.bun

# Bootstrap paths without assuming Apple Silicon or an inherited login environment.
for prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew
    if test -x $prefix/bin/brew
        fish_add_path --global --path $prefix/bin $prefix/sbin
        break
    end
end
fish_add_path --global --path $HOME/bin $HOME/.local/bin $HOME/.scripts $GOPATH/bin $BUN_INSTALL/bin $HOME/.typst/bin

if status is-interactive
    # Reconcile plugins when the shared manifest changes, keeping it authoritative.
    if not functions -q fisher
        curl --http1.1 -fsSL --retry 3 https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    end
    if functions -q fisher
        set -l plugins (cat "$__fish_config_dir/fish_plugins")
        set -l desired (string lower -- $plugins)
        if test "$desired" != "$_fisher_plugins"; or not test -f "$__fish_config_dir/functions/fisher.fish"
            fisher update
            printf '%s\n' $plugins > "$__fish_config_dir/fish_plugins"
        end
    end

    set -g fish_greeting ""
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_color_scheme terminal-dark
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always
    set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"

    switch (uname -s)
        case Darwin
            alias ls 'ls -p -G'
            source (status dirname)/config-osx.fish
        case Linux
            alias ls 'ls -p --color=auto'
            source (status dirname)/config-linux.fish
    end
    alias la 'ls -A'
    if type -q eza
        alias ll 'eza -l -g --icons'
    else
        alias ll 'ls -l'
    end
    alias lla 'll -a'
    alias g git
    if type -q nvim
        alias vim nvim
    end

    if type -q bass; and type -q brew
        set -l nvm_prefix (brew --prefix nvm 2>/dev/null)
        if test -s "$nvm_prefix/nvm.sh"
            bass source "$nvm_prefix/nvm.sh"
        end
    end
end

if test -f (status dirname)/config-local.fish
    source (status dirname)/config-local.fish
end

# Only attach from a real terminal; service calls and Neovim must never attach.
if status is-interactive; and isatty stdin; and isatty stdout; and not set -q TMUX; and type -q tmux
    tmux new-session -A -s base
end
