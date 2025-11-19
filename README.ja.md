# WezTerm Tab Colorizer

WezTermのタブに色を付けて、視覚的に区別しやすくするプラグインです。タブタイトルの変更機能も提供します。

## 機能

- 🎨 **タブの自動カラーリング**: タブインデックスに応じて異なる色を自動的に割り当て
- 🔄 **循環カラーパレット**: 設定したカラーパレットから循環的に色を選択
- ✨ **アクティブ/非アクティブの視覚的区別**: アクティブなタブは明るく、非アクティブなタブは暗く表示
- 🖱️ **ホバーエフェクト**: マウスホバー時に色を明るく表示
- 📝 **タブタイトル変更**: キーバインディングで簡単にタブタイトルを変更
- ⚙️ **高度なカスタマイズ**: カラーパレット、明度、キーバインドなど、すべて設定可能

## インストール

WezTermの設定ファイル（通常は `~/.wezterm.lua`）に以下を追加します:

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('https://github.com/ktutumi/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- プラグインを適用（デフォルト設定）
tab_colorizer.apply_to_config(config)

return config
```

### ローカル開発版を使用する場合

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

tab_colorizer.apply_to_config(config)

return config
```

## 基本的な使い方

### デフォルト設定で使用

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('https://github.com/ktutumi/wezterm-tab-colorizer')

local config = wezterm.config_builder()

tab_colorizer.apply_to_config(config)

return config
```

### カスタム設定で使用

```lua
local wezterm = require('wezterm')
local tab_colorizer = wezterm.plugin.require('https://github.com/ktutumi/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- カスタム設定
local plugin_config = {
  -- カラーパレット（好きな色を指定）
  colors = {
    '#e74c3c', -- 赤
    '#3498db', -- 青
    '#2ecc71', -- 緑
    '#f39c12', -- オレンジ
    '#9b59b6', -- 紫
  },

  -- 非アクティブタブの暗さ（0.0-1.0、0.0で真っ黒、1.0で変化なし）
  inactive_brightness = 0.6,

  -- ホバー時の明るさ（1.0より大きい値で明るくなる）
  hover_brightness = 1.3,

  -- タブタイトル変更のキーバインド
  set_title_key = { key = 'R', mods = 'CTRL|SHIFT' },

  -- プロンプトのメッセージ
  prompt_message = 'Enter tab title:',

  -- 前景色（テキストの色）
  foreground_color = '#ffffff',

  -- 非アクティブタブの前景色
  inactive_foreground_color = '#cccccc',
}

tab_colorizer.apply_to_config(config, plugin_config)

return config
```

### キーバインドを無効化する場合

```lua
local plugin_config = {
  disable_keybind = true,
}

tab_colorizer.apply_to_config(config, plugin_config)
```

## 設定オプション

| オプション | 型 | デフォルト値 | 説明 |
|-----------|-----|------------|------|
| `colors` | `table` | 7色のパレット | タブに割り当てるカラーパレット（HEX形式） |
| `inactive_brightness` | `number` | `0.5` | 非アクティブタブの暗さ（0.0-1.0） |
| `hover_brightness` | `number` | `1.2` | ホバー時の明るさ（1.0以上） |
| `set_title_key` | `table` | `{ key = 'T', mods = 'CTRL|SHIFT' }` | タブタイトル変更のキーバインド |
| `disable_keybind` | `boolean` | `false` | キーバインドを無効化 |
| `prompt_message` | `string` | `'タブタイトルを入力:'` | プロンプトメッセージ |
| `foreground_color` | `string` | `'#ffffff'` | アクティブタブのテキスト色 |
| `inactive_foreground_color` | `string` | `'#a0a0a0'` | 非アクティブタブのテキスト色 |

## デフォルトのカラーパレット

```lua
{
  '#ff6b6b', -- 赤
  '#4ecdc4', -- シアン
  '#45b7d1', -- 青
  '#f9ca24', -- 黄
  '#6ab04c', -- 緑
  '#c44569', -- ピンク
  '#786fa6', -- 紫
}
```

## タブタイトルの変更方法

1. デフォルトでは `Ctrl+Shift+T` を押す
2. プロンプトが表示されるので、新しいタブタイトルを入力
3. Enterキーで確定

## 動作要件

- WezTerm バージョン 20220807-113146-c2fee766 以降
- 以下のAPIを使用しています:
  - `format-tab-title` イベント
  - `tab:set_title()` メソッド
  - `window:active_tab()` メソッド

## トラブルシューティング

### 色が表示されない

- WezTermのバージョンが要件を満たしているか確認してください
- `wezterm --version` でバージョンを確認できます

### キーバインドが動作しない

- 他の設定とキーバインドが競合している可能性があります
- `set_title_key` オプションで別のキーに変更してください

### タブタイトルが変更できない

- `disable_keybind = true` になっていないか確認してください
- コマンドラインからも変更可能です: `wezterm cli set-tab-title "新しいタイトル"`

## ライセンス

MIT License

## 貢献

バグ報告や機能要望は、GitHubのIssueでお願いします。

## 作者

Koichi Tsutsumi (ktutumi)
