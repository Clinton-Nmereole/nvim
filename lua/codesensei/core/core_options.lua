local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 2
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.ignorecase = true
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.updatetime = 200
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"


