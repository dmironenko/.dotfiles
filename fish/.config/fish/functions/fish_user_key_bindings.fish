function fish_user_key_bindings
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --directory=\co
    end
    bind \cf fzf_change_directory
    bind \cl forward-char
    bind \cd delete-char
end
