function ssh_add_yubikey
    set -l provider (__ssh_yubikey_provider); or return
    # Reload a registered provider; a first load has nothing to remove.
    ssh-add -e "$provider" >/dev/null 2>&1
    ssh-add -s "$provider"; or return
    ssh-add -L | string match -r '.*Public key for (Key Management|PIV Attestation).*' | while read -l key
        printf '%s\n' "$key" | ssh-add -d -
    end
end
