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
  "ThePrimeagen/harpoon",
  "folke/zen-mode.nvim",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
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
  "HiPhish/rainbow-delimiters.nvim"
}
