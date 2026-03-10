local opt = vim.opt

-- エンコーディング
opt.encoding = "utf-8"

-- 表示
opt.number = true
opt.title = true
opt.showmatch = true
opt.cursorline = true
opt.display = "lastline"
opt.colorcolumn = "81"
opt.termguicolors = true

-- インデント
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.hlsearch = true

-- その他
opt.history = 5000
opt.visualbell = true
opt.errorbells = false
opt.backup = false
opt.swapfile = false
opt.autoread = true
opt.backspace = { "indent", "eol", "start" }
opt.clipboard = { "unnamedplus", "unnamed" }
opt.syntax = "on"
