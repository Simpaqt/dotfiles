-- lua/plugins/snacks.lua
-- This file disables the dashboard component from snacks.nvim

return {
  "folke/snacks.nvim",
  opts = {
    -- Disable the dashboard component to avoid conflict with alpha
    dashboard = {
      enabled = false, -- Set to false to disable the dashboard from snacks
    },
    -- Keep other snacks configurations intact
  },
}
