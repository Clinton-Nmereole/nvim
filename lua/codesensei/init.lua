require("codesensei.lazy")
require("codesensei.core")
require("codesensei.commands")
require("codesensei.keymaps")

local theme = require("last-color").recall() or "catppuccin-mocha"
vim.cmd("colorscheme " .. theme)
vim.cmd("TransparentDisable")
