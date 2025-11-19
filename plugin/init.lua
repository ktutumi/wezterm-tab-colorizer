-- wezterm-tab-colorizer plugin
-- A plugin that colorizes tabs and allows customizable tab titles

local wezterm = require('wezterm')

local module = {}

-- Default configuration
local default_config = {
  -- Color palette
  colors = {
    '#ff6b6b', -- Red
    '#4ecdc4', -- Cyan
    '#45b7d1', -- Blue
    '#f9ca24', -- Yellow
    '#6ab04c', -- Green
    '#c44569', -- Pink
    '#786fa6', -- Purple
  },

  -- Inactive tab darkness (0.0-1.0)
  inactive_brightness = 0.5,

  -- Hover brightness adjustment
  hover_brightness = 1.2,

  -- Key binding for changing tab title
  set_title_key = { key = 'T', mods = 'CTRL|SHIFT' },

  -- Flag to disable key binding
  disable_keybind = false,

  -- Prompt message
  prompt_message = 'Enter tab title:',

  -- Foreground color (text color)
  foreground_color = '#ffffff',

  -- Inactive tab foreground color
  inactive_foreground_color = '#a0a0a0',
}

-- Function to merge configuration
local function merge_config(user_config)
  local config = {}
  for k, v in pairs(default_config) do
    config[k] = v
  end

  if user_config then
    for k, v in pairs(user_config) do
      config[k] = v
    end
  end

  return config
end

-- Convert HEX color to RGB
local function hex_to_rgb(hex)
  hex = hex:gsub('#', '')
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

-- Convert RGB to HEX color
local function rgb_to_hex(r, g, b)
  return string.format('#%02x%02x%02x', math.floor(r), math.floor(g), math.floor(b))
end

-- Function to darken a color
local function darken_color(hex_color, factor)
  local r, g, b = hex_to_rgb(hex_color)
  r = r * factor
  g = g * factor
  b = b * factor
  return rgb_to_hex(r, g, b)
end

-- Function to lighten a color
local function lighten_color(hex_color, factor)
  local r, g, b = hex_to_rgb(hex_color)
  r = math.min(255, r * factor)
  g = math.min(255, g * factor)
  b = math.min(255, b * factor)
  return rgb_to_hex(r, g, b)
end

-- Function to get tab title
local function get_tab_title(tab_info)
  local title = tab_info.tab_title
  -- Use explicitly set tab title if available
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the active pane's title
  return tab_info.active_pane.title
end

-- Plugin initialization function
local function setup(config, opts)
  local plugin_config = merge_config(opts)

  -- format-tab-title event handler
  wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title = get_tab_title(tab)

    -- Select color from tab index (cycling)
    local color_index = (tab.tab_index % #plugin_config.colors) + 1
    local bg_color = plugin_config.colors[color_index]
    local fg_color = plugin_config.foreground_color

    -- Active tab is bright, inactive is dim
    if tab.is_active then
      -- Active tab keeps original color
      fg_color = plugin_config.foreground_color
    elseif hover then
      -- Brighten slightly on hover
      bg_color = lighten_color(bg_color, plugin_config.hover_brightness)
      fg_color = plugin_config.foreground_color
    else
      -- Dim inactive tabs
      bg_color = darken_color(bg_color, plugin_config.inactive_brightness)
      fg_color = plugin_config.inactive_foreground_color
    end

    -- Fit title to maximum width
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = bg_color } },
      { Foreground = { Color = fg_color } },
      { Text = ' ' .. title .. ' ' },
    }
  end)

  -- Configure key binding for changing tab title
  if not plugin_config.disable_keybind then
    config.keys = config.keys or {}
    table.insert(config.keys, {
      key = plugin_config.set_title_key.key,
      mods = plugin_config.set_title_key.mods,
      action = wezterm.action.PromptInputLine({
        description = plugin_config.prompt_message,
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }),
    })
  end
end

-- Plugin entry point
function module.apply_to_config(config, opts)
  setup(config, opts)
end

return module
