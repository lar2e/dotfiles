# Neovim 設定ガイド

## 概要

lazy.nvim + Lua ベースのモダンな neovim 設定。

- **プラグインマネージャ**: lazy.nvim
- **カラースキーム**: TokyoNight (night)
- **LSP**: mason.nvim + nvim-lspconfig（gopls）

## ディレクトリ構成

```
nvim/
├── init.lua                  # エントリポイント。lazy.nvim の bootstrap と各モジュールのロード
└── lua/
    ├── config/
    │   ├── options.lua       # vim.opt による基本設定
    │   ├── keymaps.lua       # キーマップ定義
    │   └── autocmds.lua      # autocmd（保存時空白削除など）
    └── plugins/
        ├── colorscheme.lua   # TokyoNight
        ├── neo-tree.lua      # ファイラ
        ├── telescope.lua     # ファジーファインダー
        ├── lsp.lua           # mason + mason-lspconfig + nvim-lspconfig
        ├── cmp.lua           # nvim-cmp + LuaSnip による補完
        └── ui.lua            # lualine / gitsigns / vim-fugitive / winresizer
```

## プラグイン一覧

| プラグイン | 用途 |
|---|---|
| folke/lazy.nvim | プラグインマネージャ |
| folke/tokyonight.nvim | カラースキーム |
| nvim-neo-tree/neo-tree.nvim | ファイラ |
| nvim-telescope/telescope.nvim | ファジーファインダー |
| williamboman/mason.nvim | LSP サーバー管理 |
| williamboman/mason-lspconfig.nvim | mason と lspconfig のブリッジ |
| neovim/nvim-lspconfig | LSP 設定 |
| hrsh7th/nvim-cmp | 補完エンジン |
| L3MON4D3/LuaSnip | スニペットエンジン |
| nvim-lualine/lualine.nvim | ステータスライン |
| tpope/vim-fugitive | Git 操作 |
| lewis6991/gitsigns.nvim | Git 差分表示 |
| simeji/winresizer | ウィンドウリサイズ |

## キーマップ

### 基本

| キー | 動作 |
|---|---|
| `<Space>w` | 保存 |
| `jj` | ノーマルモードへ（インサートモード中） |
| `<F3>` | 検索ハイライトトグル |

### ウィンドウ操作

| キー | 動作 |
|---|---|
| `sj / sk / sl / sh` | ウィンドウ移動（下/上/右/左） |
| `sJ / sK / sL / sH` | ウィンドウを移動（方向） |
| `ss / sv` | 水平 / 垂直分割 |
| `sq / sQ` | ウィンドウ閉じる / バッファ削除 |
| `s= / so` | ウィンドウサイズ均等化 / 最大化 |
| `sn / sp` | 次 / 前のタブ |
| `st` | 新しいタブ |

### バッファ

| キー | 動作 |
|---|---|
| `bn / bp / bb` | 次 / 前 / 直前のバッファ |

### Telescope（ファイル検索）

| キー | 動作 |
|---|---|
| `<Space>ff` | ファイル検索 |
| `<Space>fg` | grep 検索（live grep） |
| `<Space>fb` | バッファ一覧 |
| `<Space>fh` | ヘルプ検索 |

### Neo-tree（ファイラ）

| キー | 動作 |
|---|---|
| `\` | Neo-tree トグル |

### LSP（Go ファイル内で有効）

| キー | 動作 |
|---|---|
| `gd` | 定義へジャンプ |
| `gD` | 宣言へジャンプ |
| `gr` | 参照を表示 |
| `K` | ホバーヘルプ |
| `<Space>rn` | リネーム |
| `<Space>ca` | コードアクション |
| `<Space>e` | 診断を表示 |
| `[d / ]d` | 前 / 次の診断 |

## 初回セットアップ

```bash
nvim  # 起動すると lazy.nvim が自動で全プラグインをインストール
```

起動後:

```
:checkhealth        # 健全性チェック
:Mason              # LSP サーバー管理（gopls が自動インストールされる）
```

## プラグイン追加方法

`lua/plugins/` 以下に `.lua` ファイルを追加する。lazy.nvim が自動で検出する。

```lua
-- lua/plugins/example.lua
return {
  {
    "author/plugin-name",
    opts = {},
  },
}
```
