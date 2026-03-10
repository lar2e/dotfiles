return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
      window = {
        width = 30,
        mappings = {
          ["s"] = "none",
          ["S"] = "none",
          ["<C-s>"] = "open_vsplit",
          ["<C-S>"] = "open_split",
          ["<C-l>"] = function() vim.cmd("vertical resize +2") end,
          ["<C-h>"] = function() vim.cmd("vertical resize -2") end,
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local rel = vim.fn.fnamemodify(path, ":.")
            vim.fn.setreg("+", rel)
            vim.notify("Copied: " .. rel)
          end,
        },
      },
    },
  },
}
