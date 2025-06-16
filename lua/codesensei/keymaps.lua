local keyset = vim.keymap.set

--Window keymaps
keyset("n", "<leader>sv", "<C-w>v")      -- split windows vertically
keyset("n", "<leader>sh", "<C-w>s")      -- split windows horizontally
keyset("n", "<leader>se", "<C-w>=")      -- make split windows equal
keyset("n", "<leader>sx", ":close<CR>")  -- close current split window

keyset("n", "<leader>to", ":tabnew<CR>") -- open new tab
--keyset("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keyset("n", "<leader>tn", ":tabn<CR>")   -- go to next tab
keyset("n", "<leader>tp", ":tabp<CR>")   -- go to previous tab
keyset("n", "<leader>h", "<C-w>h")       --move cursor left
keyset("n", "<leader>l", "<C-w>l")       --move cursor right
keyset("n", "<leader>mu", "<C-w>k")      --split window up horizontally
keyset("n", "<leader>md", "<C-w>j")      --split window down horizontally


keyset("n", "<leader>1", ":Run<CR>", { silent = true })
keyset("n", "<leader>2", ":Build<CR>", { silent = true })
keyset("n", "<leader>3", ":Test<CR>", { silent = true })
keyset("n", "<leader>4", ":Go<CR>", { silent = true })


keyset("n", "<leader>th", ":ColorMe<CR>")

--Select all text
keyset("n", "<leader>sa", "ggVG")

--Bufferline
keyset("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
keyset("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
keyset("n", "<leader>x", function()
    vim.cmd("bd")
    vim.cmd("bNext")
end)

--Undotree
keyset("n", "<leader>ut", ":UndotreeToggle<CR>", { silent = true })

--Spectre Search and Replace
local spectre = require("spectre")
keyset("n", "<leader>sr", function() spectre.toggle() end)
keyset("n", "<leader>sf", function() spectre.open_file_search({ selected_word = false }) end)
keyset("n", "<leader>ss", function() spectre.open() end)

--LazyGit
keyset("n", "<leader>lg", ":LazyGit<CR>", { silent = true })

--NvimTree
keyset('n', '<leader>nt', ':NvimTreeToggle<CR>')
keyset('n', '<leader>nf', ':NvimTreeFocus<CR>')


--vim diagnostic
keyset("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")

--Lsplines
local lsplines = require('lsp_lines')
keyset('n', '<leader>ll', function()
    lsplines.toggle()
end)

--Trouble
-- Lua
keyset("n", "<leader>xx", function() require("trouble").toggle() end)
keyset("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
keyset("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
keyset("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
keyset("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
keyset("n", "gR", function() require("trouble").toggle("lsp_references") end)


--Keymap for Just File commands
keyset("n", "<leader>jb", ":Justbuild<CR>")
keyset("n", "<leader>jr", ":Justrun<CR>")

--Keymap for Makefile commands
keyset("n", "<leader>mb", ":Makefile<CR>")
keyset("n", "<leader>mr", ":Makerun<CR>")

--Debugging
keyset("n", "<leader>db", ":DapToggleBreakpoint<CR>")
keyset("n", "<leader>dc", ":DapContinue<CR>")
keyset("n", "<leader>di", ":DapStepInto<CR>")
keyset("n", "<leader>do", ":DapStepOver<CR>")
keyset("n", "<leader>dO", ":DapStepOut<CR>")
keyset("n", "<leader>dr", ":DapToggleRepl<CR>")

keyset("n", "<leader>dt", ":DapTerminate<CR>")

keyset("n", "<leader>dus", function()
    local widgets = require("dap.ui.widgets");
    local sidebar = widgets.sidebar(widgets.scopes);
    sidebar.open();
end)

-- Treesitter enable highlights.
keyset("n", "<leader>te", ":TSEnable highlight<CR>")
