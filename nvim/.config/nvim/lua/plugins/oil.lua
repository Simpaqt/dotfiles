return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
  priority = 100, -- Make sure it loads before other file explorers
  opts = {
    -- Oil configuration options go here
    default_file_explorer = true,
    -- Skip the confirmation prompt when you try to create a new file
    skip_confirm_for_simple_edits = true,
    -- Use floating windows for the oil view
    float = {
      -- Set to true to enable floating window display
      enable = false, -- Change to true if you want the floating interface
      max_width = 80,
      max_height = 30,
      padding = 5,
      border = "rounded",
    },
    -- Restore window dimensions when closing
    restore_win_options = true,
    columns = {
      "icon",
      "size",
      "mtime",
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },
    -- Handle netrw-style directory opening
    use_default_keymaps = true,
    view_options = {
      show_hidden = false,
      -- This function determines whether a directory should be displayed in Oil
      is_always_hidden = function(name, bufnr)
        -- You can customize this function to exclude certain directories
        return name == ".." or name == ".git"
      end,
    },
  },
  init = function()
    -- Replace netrw with oil
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Set up autocmd to open Oil when opening a directory
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "*",
      callback = function()
        local path = vim.fn.expand("%:p")
        if vim.fn.isdirectory(path) == 1 then
          require("oil").open(path)
        end
      end,
    })
  end,
}
