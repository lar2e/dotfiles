local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 保存
map("n", "<Leader>w", ":w<CR>", opts)

-- ESC
map("i", "jj", "<ESC>", opts)

-- ハイライトトグル
map("n", "<F3>", ":set hlsearch!<CR>", opts)

-- ウィンドウ移動
map("n", "sj", "<C-w>j", opts)
map("n", "sk", "<C-w>k", opts)
map("n", "sl", "<C-w>l", opts)
map("n", "sh", "<C-w>h", opts)
map("n", "sJ", "<C-w>J", opts)
map("n", "sK", "<C-w>K", opts)
map("n", "sL", "<C-w>L", opts)
map("n", "sH", "<C-w>H", opts)
map("n", "sr", "<C-w>r", opts)
map("n", "s=", "<C-w>=", opts)
map("n", "sw", "<C-w>w", opts)
map("n", "so", "<C-w>_<C-w>|", opts)
map("n", "sO", "<C-w>=", opts)

-- タブ
map("n", "sn", "gt", opts)
map("n", "sp", "gT", opts)
map("n", "st", ":<C-u>tabnew<CR>", opts)
map("n", "ss", ":<C-u>sp<CR>", opts)
map("n", "sv", ":<C-u>vs<CR>", opts)
map("n", "sq", ":<C-u>q<CR>", opts)
map("n", "sQ", ":<C-u>bd<CR>", opts)

-- リサイズモード
local resize_mode_active = false

local function exit_resize_mode()
  if not resize_mode_active then return end
  resize_mode_active = false
  for _, key in ipairs({ 'h', 'j', 'k', 'l', '<CR>', '<Esc>' }) do
    pcall(vim.keymap.del, 'n', key)
  end
  vim.notify("-- RESIZE MODE exit --")
end

local function enter_resize_mode()
  if resize_mode_active then return end
  resize_mode_active = true
  vim.notify("-- RESIZE MODE -- (h/j/k/l: resize, Enter/Esc: exit)")

  local ropts = { noremap = true, silent = true }
  vim.keymap.set('n', 'h', function() vim.cmd('vertical resize -2') end, ropts)
  vim.keymap.set('n', 'l', function() vim.cmd('vertical resize +2') end, ropts)
  vim.keymap.set('n', 'k', function() vim.cmd('resize +2') end, ropts)
  vim.keymap.set('n', 'j', function() vim.cmd('resize -2') end, ropts)
  vim.keymap.set('n', '<CR>', exit_resize_mode, ropts)
  vim.keymap.set('n', '<Esc>', exit_resize_mode, ropts)
end

map("n", "sR", enter_resize_mode, opts)

-- バッファ移動
map("n", "bp", ":bprevious<CR>", opts)
map("n", "bn", ":bnext<CR>", opts)
map("n", "ba", ":b#<CR>", opts)

-- Neo-tree
map("n", "\\", ":Neotree toggle<CR>", opts)

-- Telescope
map("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<Leader>fg", function() require("telescope").extensions.live_grep_args.live_grep_args() end, opts)
map("n", "<Leader>fw", ":Telescope grep_string<CR>", opts)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opts)
