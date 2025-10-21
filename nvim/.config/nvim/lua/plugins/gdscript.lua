-- File: ~/.config/nvim/lua/plugins/gdscript.lua

return {
  -- Add gdscript to ensure_installed list of treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gdscript" })
      end
    end,
  },
  -- Add gdscript LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          -- The GDScript language server doesn't need special settings
          -- LazyVim will handle setup with these defaults
        },
      },
    },
  },
  -- Add filetype detection for Godot
  {
    "LazyVim/LazyVim",
    opts = {
      -- Add gdscript filetype detection
      autoformat = false, -- optional: disable autoformat for gdscript if you prefer
    },
  },
}
