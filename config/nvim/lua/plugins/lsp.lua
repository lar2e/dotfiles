return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "gopls" },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- キーマップ（LSP アタッチ時のみ有効）
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "定義へジャンプ")
          map("gD", vim.lsp.buf.declaration, "宣言へジャンプ")
          map("gi", vim.lsp.buf.implementation, "実装へジャンプ")
          map("gr", vim.lsp.buf.references, "参照を表示")
          map("K", vim.lsp.buf.hover, "ホバーヘルプ")
          map("<Leader>rn", vim.lsp.buf.rename, "リネーム")
          map("<Leader>ca", vim.lsp.buf.code_action, "コードアクション")
          map("<Leader>e", vim.diagnostic.open_float, "診断を表示")
          map("[d", vim.diagnostic.goto_prev, "前の診断")
          map("]d", vim.diagnostic.goto_next, "次の診断")
        end,
      })

      -- gopls
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      })
      vim.lsp.enable("gopls")
    end,
  },
}
