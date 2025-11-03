function fzf_change_directory
    type -q fzf; or return 127
    set -l directory (begin
        printf '%s\n' $HOME/.config $HOME
        if type -q ghq
            ghq list --full-path
        end
        command find . -maxdepth 1 -type d ! -name . ! -name .git
    end | awk '!seen[$0]++' | fzf)
    if test -n "$directory"
        builtin cd -- "$directory"; or return
        commandline -r ''
        commandline -f repaint
    end
end
