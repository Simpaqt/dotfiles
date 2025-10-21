local M = {}

vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

_G.actions = {
  open_oil = "<cmd>Oil<cr>",
}

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

function M.load_keys()
  local map = vim.keymap.set
  local actions = _G.actions

  map("n", "<leader>o", actions.open_oil, { desc = "Open oil" })
end

M.load_keys()
