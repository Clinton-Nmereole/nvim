local themes = {
  {
    "folke/tokyonight.nvim",
    opts = {},
    name = "tokyonight",
    config = function ()
      require("tokyonight").setup({
        style = "moon",
      })
    end,
    lazy = false,
    priority = 1000
  },
  {
	  "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function ()
      require("catppuccin").setup({
        flavor = "frappe"
      })
    end,
    init = function()
      --vim.cmd.colorscheme "catppuccin-frappe"
    end,
    priority = 1000,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    name = "oxocarbon",
    lazy = false
  },
  {
    "savq/melange-nvim",
    name = "melange",
    lazy = false
  },
  {
    "rmehri01/onenord.nvim",
    name = "onenord",
    lazy = false
  },
  {
    'AlexvZyl/nordic.nvim',
    name = "nordic",
    config = function()
      --require 'nordic' .load()
    end,
    lazy = false
  },
  {
    "Shatur/neovim-ayu",
    name = "ayu",
    config = function ()
      require("ayu").setup({
        mirage = false
      })
    end,
    lazy = false
  },
  {
    "ray-x/aurora",
    name = "aurora",
    lazy = false
  },
  {
    "JoosepAlviste/palenightfall.nvim",
    name = "palenightfall",
    lazy = false
  },
  {
    "gbprod/nord.nvim",
    name = "nord",
    lazy = false
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    config = function ()
      require("everforest").setup()
    end,
    lazy = false
  },
  {
    "rafamadriz/neon",
    name = "neon",
    lazy = false
  },
  {
    "RRethy/nvim-base16",
    name = "base16",
    lazy = false,
    priority = 1000,
    init = function ()
      --vim.cmd.colorscheme "base16-catppuccin-macchiato"
    end,
  },
  {
    "nobbmaestro/nvim-andromeda",
    dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
    lazy = false
  },
  {
    "dotsilas/darcubox-nvim",
  },

  --kanagawa
  {
      "rebelot/kanagawa.nvim"
  },
  {
      "EdenEast/nightfox.nvim"
  },

 }

return themes
