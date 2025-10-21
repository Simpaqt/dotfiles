return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "ibhagwan/fzf-lua", -- optional
  },
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Open Neogit",
    },
    {
      "<leader>gs",
      function()
        require("neogit").open({ kind = "split" })
      end,
      desc = "Open Neogit in split",
    },
  },
  config = function()
    require("neogit").setup({
      -- You can add any additional Neogit configuration options here if needed
    })
  end,
}
