local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 末尾の空白を保存時に自動削除
local function rtrim()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local ft = vim.bo.filetype
  if ft == "markdown" then
    vim.cmd([[%s/\s\+\(\s\{2}\)$/\1/e]])
  else
    vim.cmd([[%s/\s\+$//e]])
  end
  vim.api.nvim_win_set_cursor(0, cursor)
end

augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  callback = rtrim,
})

-- Ruby filetype
augroup("RubyFiletype", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "RubyFiletype",
  pattern = { "Capfile", "Gemfile", "*.god", "*.ru" },
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- grep 後に quickfix を自動表示
augroup("QuickfixOpen", { clear = true })
autocmd("QuickFixCmdPost", {
  group = "QuickfixOpen",
  pattern = "*grep*",
  command = "cwindow",
})
