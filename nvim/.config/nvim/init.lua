if vim.fn.has("nvim-0.12") == 0 then
  error("These dotfiles require Neovim >= 0.12; run make install to upgrade")
end

if vim.loader then
	vim.loader.enable()
end

require("config.lazy")
