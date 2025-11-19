-- Custom color palette example
-- Colorize tabs with your favorite colors

local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- Custom color palette
local plugin_config = {
  colors = {
    '#e74c3c', -- Red
    '#3498db', -- Blue
    '#2ecc71', -- Green
    '#f39c12', -- Orange
    '#9b59b6', -- Purple
    '#1abc9c', -- Turquoise
    '#e67e22', -- Carrot
    '#34495e', -- Dark Gray
  },
}

tab_colorizer.apply_to_config(config, plugin_config)

return config
