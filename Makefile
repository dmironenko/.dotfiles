SHELL := /bin/bash
.DEFAULT_GOAL := install
PACKAGES := git nvim ghostty fish tmux lazygit scripts
STOW := stow --restow --dir="$(CURDIR)" --target="$(HOME)"

.PHONY: install sync
install:
	brew bundle --file=Brewfile
	$(MAKE) sync
	fish -ic exit
	@set -e; \
		fish_path=$$(command -v fish); \
		grep -Fxq "$$fish_path" /etc/shells || printf '%s\n' "$$fish_path" | sudo tee -a /etc/shells >/dev/null; \
		if [ "$$(uname -s)" = Darwin ]; then \
			login_shell=$$(dscl . -read "/Users/$$(id -un)" UserShell | cut -d ' ' -f 2); \
		else \
			login_shell=$$(getent passwd "$$(id -un)" | cut -d: -f7); \
		fi; \
		[ "$$login_shell" = "$$fish_path" ] || chsh -s "$$fish_path"

sync:
	$(STOW) $(PACKAGES)

sync-%:
	$(STOW) $*
