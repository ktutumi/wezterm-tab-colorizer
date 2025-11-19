-- Basic usage example
-- Use plugin with default settings

local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- Apply plugin (default settings)
tab_colorizer.apply_to_config(config)

return config
