# Local Testing Guide

This guide explains how to test the WezTerm Tab Colorizer plugin in your local environment.

## Prerequisites

- WezTerm version 20220807-113146-c2fee766 or later installed
- Access to WezTerm configuration file (`~/.wezterm.lua`)

## Testing Methods

### Method 1: Using test-config.lua

1. Navigate to the plugin directory:

```bash
cd /path/to/wezterm-tab-colorizer
```

2. Launch WezTerm with this test configuration:

```bash
wezterm --config-file $(pwd)/test-config.lua
```

3. Test the following:
   - [ ] Open multiple tabs and verify each displays a different color
   - [ ] Verify that the active tab displays brightly
   - [ ] Verify that inactive tabs display dimly
   - [ ] Verify that hovering over a tab brightens the color
   - [ ] Verify that `Ctrl+Shift+T` displays a prompt
   - [ ] Verify that you can enter and change the tab title

### Method 2: Adding to Existing Configuration File

1. Edit `~/.wezterm.lua`:

```lua
local wezterm = require('wezterm')

-- Load local plugin
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- Apply plugin
tab_colorizer.apply_to_config(config)

-- Other settings...

return config
```

2. Restart WezTerm or reload configuration (`Ctrl+Shift+R`, depending on settings)

### Method 3: Using wezterm.plugin.update_all()

To update and test the plugin:

1. Open Debug Overlay (usually `Ctrl+Shift+L`)

2. Execute the following command:

```lua
wezterm.plugin.update_all()
```

3. Restart WezTerm

## Test Checklist

### Basic Functionality

- [ ] Plugin loads successfully
- [ ] Tabs are displayed with color coding
- [ ] Colors cycle when more than 7 tabs are opened
- [ ] No errors occur

### Coloring Functionality

- [ ] Different colors are assigned to each tab
- [ ] Active tab displays brightly
- [ ] Inactive tabs display dimly
- [ ] Color brightens on hover
- [ ] Text displays in readable colors

### Tab Title Modification

- [ ] `Ctrl+Shift+T` displays a prompt
- [ ] Entered title is reflected in the tab
- [ ] No error occurs when confirming with blank input
- [ ] Japanese titles also display correctly

### Customization Functionality

- [ ] Custom color palette is applied correctly
- [ ] Changes to `inactive_brightness` are reflected
- [ ] Changes to `hover_brightness` are reflected
- [ ] Custom key bindings work
- [ ] Key bindings are disabled with `disable_keybind`

## Troubleshooting

### Plugin Not Loading

```lua
-- Execute in Debug Overlay
-- Check plugin list
for _, plugin in ipairs(wezterm.plugin.list()) do
  print(plugin.url, plugin.plugin_dir)
end
```

### Colors Not Displaying

- Check WezTerm version: `wezterm --version`
- Check error logs: Check for error messages in Debug Overlay

### Key Bindings Not Working

- Check if there are conflicts with other key bindings
- Try changing to custom key bindings

## Performance Testing

Test performance by opening many tabs:

1. Open more than 20 tabs
2. Verify that tab switching works without delay
3. Check CPU and memory usage

## Getting Debug Logs

If issues occur:

```bash
# Launch WezTerm in debug mode
WEZTERM_LOG=debug wezterm --config-file test-config.lua
```

## After Testing

Once all tests are complete:

1. Verify that all checklist items are ✓
2. If there are issues, fix `plugin/init.lua`
3. Commit changes

## Next Steps

Once testing is complete, proceed with creating a GitHub repository and preparing for public release.
