-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- NixOS-specific adjustments for Neovim

-- Prevent Mason from managing certain tools on NixOS
vim.g.mason_ensure_installed = vim.g.mason_ensure_installed or {}
vim.g.mason_ensure_installed_stylua = false

-- Set environment variables to help finding NixOS binaries
vim.env.PATH = vim.env.PATH or ""
if not string.find(vim.env.PATH, "/etc/profiles/per-user") then
  vim.env.PATH = "/etc/profiles/per-user/" .. vim.fn.expand("$USER") .. "/bin:" .. vim.env.PATH
end

-- Return an empty table to be compatible with require()
return {}
