-- カスタムキーバインドの例
-- デフォルトのキーバインドを変更

local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- カスタムキーバインド
local plugin_config = {
  -- Ctrl+Shift+R でタブタイトルを変更
  set_title_key = { key = 'R', mods = 'CTRL|SHIFT' },

  -- プロンプトメッセージも英語に変更
  prompt_message = 'Enter new tab title:',
}

tab_colorizer.apply_to_config(config, plugin_config)

return config
