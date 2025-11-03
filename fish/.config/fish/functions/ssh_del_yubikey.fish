function ssh_del_yubikey
    set -l provider (__ssh_yubikey_provider); or return
    ssh-add -e "$provider"
end
