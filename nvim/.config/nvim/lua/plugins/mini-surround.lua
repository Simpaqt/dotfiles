-- ~/.config/nvim/lua/plugins/mini-surround.lua
return {
  "nvim-mini/mini.surround",
  version = false, -- Latest version
  config = function()
    require("mini.surround").setup({
      -- Keep this simple with no custom surroundings
      -- The built-in 't' identifier should work for tags
      custom_surroundings = nil,

      highlight_duration = 500,

      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",

        suffix_last = "l",
        suffix_next = "n",
      },

      n_lines = 20,
      respect_selection_type = false,
      search_method = "cover",
      silent = false,
    })
  end,
}
