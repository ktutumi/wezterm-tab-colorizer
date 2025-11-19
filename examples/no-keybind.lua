-- キーバインドを無効化する例
-- 既存のキーバインドと競合する場合や、タブタイトル変更機能が不要な場合

local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- キーバインドを無効化
local plugin_config = {
  disable_keybind = true,
}

tab_colorizer.apply_to_config(config, plugin_config)

-- 注意: キーバインドを無効化しても、コマンドラインからタブタイトルは変更可能です
-- 使い方: wezterm cli set-tab-title "新しいタイトル"

return config
