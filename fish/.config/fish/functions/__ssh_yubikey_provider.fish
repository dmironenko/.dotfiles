function __ssh_yubikey_provider
    type -q brew; or return 127
    set -l prefix (brew --prefix yubico-piv-tool)
    for library in $prefix/lib/libykcs11.dylib $prefix/lib/libykcs11.so
        if test -f "$library"
            printf '%s\n' "$library"
            return
        end
    end
    printf 'YubiKey PKCS#11 library is missing; run make install.\n' >&2
    return 1
end
