# ローカルテストガイド

このガイドでは、WezTerm Tab Colorizerプラグインをローカル環境でテストする方法を説明します。

## 前提条件

- WezTerm 20220807-113146-c2fee766 以降がインストールされていること
- WezTermの設定ファイル（`~/.wezterm.lua`）にアクセスできること

## テスト方法

### 方法1: test-config.lua を使用する

1. プラグインのディレクトリに移動：

```bash
cd /path/to/wezterm-tab-colorizer
```

2. WezTermを起動時にこのテスト設定を使用：

```bash
wezterm --config-file $(pwd)/test-config.lua
```

3. テストする内容：
   - [ ] 複数のタブを開いて、それぞれ異なる色が表示されることを確認
   - [ ] アクティブなタブが明るく表示されることを確認
   - [ ] 非アクティブなタブが暗く表示されることを確認
   - [ ] タブにマウスをホバーすると色が明るくなることを確認
   - [ ] `Ctrl+Shift+T` でプロンプトが表示されることを確認
   - [ ] タブタイトルを入力して変更できることを確認

### 方法2: 既存の設定ファイルに追加する

1. `~/.wezterm.lua`を編集：

```lua
local wezterm = require('wezterm')

-- ローカルのプラグインを読み込み
local tab_colorizer = wezterm.plugin.require('file:///path/to/wezterm-tab-colorizer')

local config = wezterm.config_builder()

-- プラグインを適用
tab_colorizer.apply_to_config(config)

-- その他の設定...

return config
```

2. WezTermを再起動または設定をリロード（`Ctrl+Shift+R`、設定による）

### 方法3: wezterm.plugin.update_all() を使用する

プラグインを更新してテストする場合：

1. Debug Overlayを開く（通常は `Ctrl+Shift+L`）

2. 以下のコマンドを実行：

```lua
wezterm.plugin.update_all()
```

3. WezTermを再起動

## テストチェックリスト

### 基本機能

- [ ] プラグインが正常にロードされる
- [ ] タブが色分けされて表示される
- [ ] 7色以上のタブを開いた場合、色が循環する
- [ ] エラーが発生しない

### カラーリング機能

- [ ] 各タブに異なる色が割り当てられる
- [ ] アクティブなタブが明るく表示される
- [ ] 非アクティブなタブが暗く表示される
- [ ] ホバー時に色が明るくなる
- [ ] テキストが読みやすい色で表示される

### タブタイトル変更機能

- [ ] `Ctrl+Shift+T` でプロンプトが表示される
- [ ] 入力したタイトルがタブに反映される
- [ ] 空白のまま確定してもエラーが発生しない
- [ ] 日本語のタイトルも正しく表示される

### カスタマイズ機能

- [ ] カスタムカラーパレットが正しく適用される
- [ ] `inactive_brightness` の変更が反映される
- [ ] `hover_brightness` の変更が反映される
- [ ] カスタムキーバインドが動作する
- [ ] `disable_keybind` で キーバインドが無効化される

## トラブルシューティング

### プラグインがロードされない

```lua
-- Debug Overlayで実行
-- プラグイン一覧を確認
for _, plugin in ipairs(wezterm.plugin.list()) do
  print(plugin.url, plugin.plugin_dir)
end
```

### 色が表示されない

- WezTermのバージョンを確認：`wezterm --version`
- エラーログを確認：Debug Overlayでエラーメッセージを確認

### キーバインドが動作しない

- 他のキーバインドと競合していないか確認
- カスタムキーバインドに変更してみる

## パフォーマンステスト

大量のタブを開いてパフォーマンスを確認：

1. 20個以上のタブを開く
2. タブの切り替えが遅延なく動作することを確認
3. CPUやメモリの使用率を確認

## デバッグログの取得

問題が発生した場合：

```bash
# デバッグモードでWezTermを起動
WEZTERM_LOG=debug wezterm --config-file test-config.lua
```

## テスト完了後

すべてのテストが完了したら：

1. チェックリストがすべて✓になっていることを確認
2. 問題があれば、`plugin/init.lua` を修正
3. 変更をコミット

## 次のステップ

テストが完了したら、GitHubにリポジトリを作成して公開する準備を進めます。
