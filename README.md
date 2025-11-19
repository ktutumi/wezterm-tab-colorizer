# WezTerm Tab Colorizer

A WezTerm plugin that colorizes tabs for easy visual distinction and provides tab title customization.

## Features

- 🎨 **Automatic Tab Coloring**: Automatically assigns different colors based on tab index
- 🔄 **Cycling Color Palette**: Cyclically selects colors from the configured color palette
- ✨ **Visual Active/Inactive Distinction**: Active tabs are bright, inactive tabs are dimmed
- 🖱️ **Hover Effect**: Brightens color on mouse hover
- 📝 **Tab Title Modification**: Easily change tab titles with key bindings
- ⚙️ **Extensive Customization**: Customize color palette, brightness, key bindings, and more

## Installation

Add the following to your WezTerm configuration file (usually `~/.wezterm.lua`):

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('https://github.com/ktutumi/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- Apply plugin with default settings
tab_colorizer.apply_to_config(config)

return config
```

### Using Local Development Version

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

tab_colorizer.apply_to_config(config)

return config
```

## Basic Usage

### Using Default Settings

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('https://github.com/ktutumi/wezterm-tab-colorizer')

local config = wezterm.config_builder()

tab_colorizer.apply_to_config(config)

return config
```

### Using Custom Settings

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('https://github.com/ktutumi/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- Custom settings
local plugin_config = {
  -- Color palette (specify your favorite colors)
  colors = {
    '#e74c3c', -- Red
    '#3498db', -- Blue
    '#2ecc71', -- Green
    '#f39c12', -- Orange
    '#9b59b6', -- Purple
  },

  -- Inactive tab darkness (0.0-1.0, 0.0 is completely black, 1.0 is no change)
  inactive_brightness = 0.6,

  -- Hover brightness (values greater than 1.0 make it brighter)
  hover_brightness = 1.3,

  -- Key binding for changing tab title
  set_title_key = { key = 'R', mods = 'CTRL|SHIFT' },

  -- Prompt message
  prompt_message = 'Enter tab title:',

  -- Foreground color (text color)
  foreground_color = '#ffffff',

  -- Inactive tab foreground color
  inactive_foreground_color = '#cccccc',
}

tab_colorizer.apply_to_config(config, plugin_config)

return config
```

### Disabling Key Bindings

```lua
local plugin_config = {
  disable_keybind = true,
}

tab_colorizer.apply_to_config(config, plugin_config)
```

## Configuration Options

| Option | Type | Default Value | Description |
|--------|------|--------------|-------------|
| `colors` | `table` | 7-color palette | Color palette assigned to tabs (HEX format) |
| `inactive_brightness` | `number` | `0.5` | Inactive tab darkness (0.0-1.0) |
| `hover_brightness` | `number` | `1.2` | Hover brightness (1.0 or higher) |
| `set_title_key` | `table` | `{ key = 'T', mods = 'CTRL|SHIFT' }` | Key binding for changing tab title |
| `disable_keybind` | `boolean` | `false` | Disable key binding |
| `prompt_message` | `string` | `'Enter tab title:'` | Prompt message |
| `foreground_color` | `string` | `'#ffffff'` | Active tab text color |
| `inactive_foreground_color` | `string` | `'#a0a0a0'` | Inactive tab text color |

## Default Color Palette

```lua
{
  '#ff6b6b', -- Red
  '#4ecdc4', -- Cyan
  '#45b7d1', -- Blue
  '#f9ca24', -- Yellow
  '#6ab04c', -- Green
  '#c44569', -- Pink
  '#786fa6', -- Purple
}
```

## How to Change Tab Title

1. Press `Ctrl+Shift+T` by default
2. A prompt will appear, enter the new tab title
3. Press Enter to confirm

## Requirements

- WezTerm version 20220807-113146-c2fee766 or later
- Uses the following APIs:
  - `format-tab-title` event
  - `tab:set_title()` method
  - `window:active_tab()` method

## Troubleshooting

### Colors Not Showing

- Check if your WezTerm version meets the requirements
- You can check the version with `wezterm --version`

### Key Bindings Not Working

- There may be a conflict with other key bindings in your configuration
- Change to a different key using the `set_title_key` option

### Cannot Change Tab Title

- Make sure `disable_keybind = true` is not set
- You can also change from the command line: `wezterm cli set-tab-title "New Title"`

## License

MIT License

## Contributing

Bug reports and feature requests are welcome on GitHub Issues.

## Author

Koichi Tsutsumi (ktutumi)
