-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  { "ThePrimeagen/harpoon", opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      }
    }
  },
  "folke/zen-mode.nvim",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
     return require "custom.configs.null-ls"
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },
  "windwp/nvim-ts-autotag",
  "sindrets/diffview.nvim",
  "HiPhish/rainbow-delimiters.nvim",
  { "zbirenbaum/copilot.lua" },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
    }
  },
  {
      'cameron-wags/rainbow_csv.nvim',
      config = true,
      ft = {
          'csv',
          'tsv',
          'csv_semicolon',
          'csv_whitespace',
          'csv_pipe',
          'rfc_csv',
          'rfc_semicolon'
      },
      cmd = {
          'RainbowDelim',
          'RainbowDelimSimple',
          'RainbowDelimQuoted',
          'RainbowMultiDelim'
      }
  }
}
