-- Pastel color theme example
-- Colorize tabs with soft pastel colors

local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- Pastel color palette
local plugin_config = {
  colors = {
    '#ffb3ba', -- Light Pink
    '#bae1ff', -- Light Blue
    '#baffc9', -- Light Green
    '#ffffba', -- Light Yellow
    '#ffdfba', -- Light Orange
    '#e0bbff', -- Light Purple
    '#c9f0ff', -- Light Sky
  },

  -- Pastel colors are bright, so darken inactive tabs more
  inactive_brightness = 0.4,

  -- Set text to darker color
  foreground_color = '#333333',
  inactive_foreground_color = '#666666',
}

tab_colorizer.apply_to_config(config, plugin_config)

return config
