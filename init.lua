--Allow last set color theme to persist

vim.g.mapleader = " "
vim.g.maplocalleader = ","
--vim.cmd("colorscheme base16-catppuccin-mocha")


vim.api.nvim_create_autocmd("VimEnter", { command = "hi NvimTreeNormal guibg=NONE ctermbg=NONE" })

require("codesensei")

--transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
