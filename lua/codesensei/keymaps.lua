local keyset = vim.keymap.set

--Window keymaps
keyset("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })      -- split windows vertically
keyset("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })      -- split windows horizontally
keyset("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })      -- make split windows equal
keyset("n", "<leader>sx", ":close<CR>", { desc = "Close split" })  -- close current split window

keyset("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" }) -- open new tab
--keyset("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keyset("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })   -- go to next tab
keyset("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })   -- go to previous tab
keyset("n", "<leader>h", "<C-w>h", { desc = "Focus left window" })       --move cursor left
keyset("n", "<leader>l", "<C-w>l", { desc = "Focus right window" })       --move cursor right
keyset("n", "<leader>mu", "<C-w>k", { desc = "Focus upper window" })      --split window up horizontally
keyset("n", "<leader>md", "<C-w>j", { desc = "Focus lower window" })      --split window down horizontally

keyset("n", "<leader>1", ":Run<CR>", { silent = true, desc = "Run program" })
keyset("n", "<leader>2", ":Build<CR>", { silent = true, desc = "Build to quickfix" })
keyset("n", "<leader>3", ":Test<CR>", { silent = true, desc = "Test to quickfix" })
keyset("n", "<leader>4", ":Go<CR>", { silent = true, desc = "Run Go project" })

keyset("n", "<leader>5", ":Execute<CR>", { silent = true, desc = "Execute binary" })

keyset("n", "<leader>th", ":ColorMe<CR>", { desc = "Choose colorscheme" })

--Select all text
keyset("n", "<leader>sa", "ggVG", { desc = "Select all" })

--Bufferline
keyset("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
keyset("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })
keyset("n", "<leader>x", function()
    vim.cmd("bd")
    vim.cmd("bNext")
end, { desc = "Close buffer" })

--Undotree
keyset("n", "<leader>ut", ":UndotreeToggle<CR>", { silent = true, desc = "Toggle undo history" })

--Spectre Search and Replace
local spectre = require("spectre")
keyset("n", "<leader>sr", function()
    spectre.toggle()
end, { desc = "Toggle search and replace" })
keyset("n", "<leader>sf", function()
    spectre.open_file_search({ selected_word = false })
end, { desc = "Replace in current file" })
keyset("n", "<leader>ss", function()
    spectre.open()
end, { desc = "Search and replace" })

--LazyGit
keyset("n", "<leader>lg", ":LazyGit<CR>", { silent = true, desc = "Open LazyGit" })

--NvimTree
keyset("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
keyset("n", "<leader>nf", ":NvimTreeFocus<CR>", { desc = "Focus file tree" })

--vim diagnostic
keyset("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show line diagnostics" })

--Lsplines
local lsplines = require("lsp_lines")
keyset("n", "<leader>ll", function()
    lsplines.toggle()
end, { desc = "Toggle diagnostic lines" })

--Trouble
-- Lua
keyset("n", "<leader>xx", function()
    require("trouble").toggle()
end, { desc = "Toggle Trouble" })
keyset("n", "<leader>xb", function()
    require("trouble").filter("diagnostics", { buf = 0 })
end, { desc = "Filter buffer diagnostics" })
keyset("n", "<leader>xd", function()
    require("trouble").toggle("diagnostics")
end, { desc = "Workspace diagnostics" })
keyset("n", "<leader>xq", function()
    require("trouble").toggle("quickfix")
end, { desc = "Quickfix list" })
keyset("n", "<leader>xl", function()
    require("trouble").toggle("loclist")
end, { desc = "Location list" })
keyset("n", "gR", function()
    require("trouble").toggle("lsp_references")
end, { desc = "LSP references in Trouble" })

keyset("n", "<leader>xp", function()
    require("trouble").toggle("lsp_definitions")
end, { desc = "LSP definitions in Trouble" })

--Keymap for Just File commands
keyset("n", "<leader>jb", ":Justbuild<CR>", { desc = "Just build to quickfix" })
keyset("n", "<leader>jr", ":Justrun<CR>", { desc = "Just run" })

--Keymap for Makefile commands
keyset("n", "<leader>mb", ":Makefile<CR>", { desc = "Make build to quickfix" })
keyset("n", "<leader>mr", ":Makerun<CR>", { desc = "Make run" })

--Debugging
keyset("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
keyset("n", "<leader>dc", ":DapContinue<CR>", { desc = "Continue debugging" })
keyset("n", "<leader>di", ":DapStepInto<CR>", { desc = "Step into" })
keyset("n", "<leader>do", ":DapStepOver<CR>", { desc = "Step over" })
keyset("n", "<leader>dO", ":DapStepOut<CR>", { desc = "Step out" })
keyset("n", "<leader>dr", ":DapToggleRepl<CR>", { desc = "Toggle debug REPL" })

keyset("n", "<leader>dt", ":DapTerminate<CR>", { desc = "Terminate debugging" })

keyset("n", "<leader>dus", function()
    local widgets = require("dap.ui.widgets")
    local sidebar = widgets.sidebar(widgets.scopes)
    sidebar.open()
end, { desc = "Show debug scopes" })

keyset("n", "<leader>ro", ":term nu --login -c runodin<CR>", { desc = "Run Odin with Nushell" })

--PI Agent Keymaps
--Open/close pi chat panel
--keyset("n", "<leader>aa", require("pi-nvim").toggle, { desc = "Toggle Pi (chat)" })

-- Treesitter enable highlights.
keyset("n", "<leader>te", ":TSEnable highlight<CR>", { desc = "Enable Treesitter highlighting" })

-- ============================================================================
-- OIL.NVIM -- File explorer as a regular buffer
-- ============================================================================
-- Global keymaps (set in core_plugins.lua lazy spec keys):
--   <leader>e -> Open oil explorer at current buffer
--   -         -> Open oil at parent directory
-- Buffer-local keymaps (set in plugin_configs/oil.lua):
--   <CR>      -> Open file or enter directory
--   <C-s>     -> Open in vertical split
--   <C-h>     -> Open in horizontal split
--   <C-t>     -> Open in new tab
--   <C-p>     -> Preview file
--   -         -> Go to parent directory
--   _         -> Open CWD
--   `         -> cd to directory
--   ~         -> tcd to directory (tab-local)
--   gs        -> Cycle sort (name / type / modified)
--   g.        -> Toggle hidden files
--   gx        -> Open external (system app)
--   g\        -> Toggle trash
--   <BS>      -> Go to parent directory
--   <C-r>     -> Refresh

-- ============================================================================
-- TELESCOPE -- File and text navigation
-- ============================================================================
-- Defined once in plugin_configs/telescope.lua:
--   <leader>ff -> Find project files
--   <leader>fg -> Live grep across project files
--   <leader>fb -> Open buffers (including unsaved buffers)
--   <leader>fc -> Grep word under cursor
--   <leader>fz -> Fuzzy search lines in the current buffer
--   <leader>fh -> Search help tags
--   <leader>fn -> Find Neovim config files from any project
-- Picker keys: <CR> open, <C-x> horizontal split, <C-v> vertical split,
-- <C-t> new tab, <C-n>/<C-p> move, <C-q> send results to quickfix.

-- ============================================================================
-- CONFORM.NVIM -- Formatter (format-on-save: automatic)
-- ============================================================================
-- Manual format keymaps:
keyset("n", "<leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
keyset("v", "<leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format selection" })

-- ============================================================================
-- NVIM-COLORIZER -- Highlight color codes (no keymaps needed)
-- ============================================================================
-- Commands available:
--   :ColorizerToggle          -> Toggle colorizer for current buffer
--   :ColorizerAttachToBuffer  -> Attach to current buffer
--   :ColorizerDetachFromBuffer -> Detach from current buffer
--   :ColorizerReloadAllBuffers -> Reload all buffers
--   :ColorizerToggleHighlight -> Toggle color highlight style

-- ============================================================================
-- SHOWKEYS -- Keycast overlay (nvzone/showkeys)
-- ============================================================================
keyset("n", "<leader>uk", ":ShowkeysToggle<CR>", { desc = "Toggle Showkeys Overlay" })

-- ============================================================================
-- MINI.NVIM -- Modular plugin collection
-- ============================================================================
-- mini.ai (text objects) -- v<motion> + key:
--   af / if     -> Function (treesitter @function.outer/inner)
--   ao / io     -> Block, conditional, loop
--   ac / ic     -> Class
--   at / it     -> Comment
--   ad / id     -> Digits
--   ae / ie     -> Entire buffer
--   aA / iA     -> Argument / parameter (inside brackets)
-- mini.surround:
--   sa<motion><char> -> Add surrounding (e.g., saiw")
--   sd<char>       -> Delete surrounding
--   sf<char>       -> Find right surrounding
--   sF<char>       -> Find left surrounding
--   sh<char>       -> Highlight surrounding
--   sr<old><new>   -> Replace surrounding
-- mini.comment:
--   gc<motion>    -> Toggle comment (operator)
--   gcc           -> Toggle comment on current line
--   gc            -> Toggle comment (visual mode)
-- mini.indentscope:
--   [I / ]I       -> Jump to top / bottom of indent scope
--   vii / vai     -> Select inside / around indent scope
-- mini.cursorword: auto-highlights word under cursor (delay: 100ms)
-- mini.trailspace: auto-highlights trailing whitespace
-- nvim-autopairs handles typed brackets and quotes; Blink handles completion brackets.

-- ============================================================================
-- GITSIGNS.NVIM -- Git gutter signs, blame, hunk nav
-- ============================================================================
-- Buffer-local keymaps (set via on_attach in plugin_configs/gitsigns.lua):
--   ]c / [c         -> Next / prev git hunk
--   <leader>hs      -> Stage hunk
--   <leader>hr      -> Reset hunk
--   <leader>hS      -> Stage entire buffer
--   <leader>hu      -> Undo stage hunk
--   <leader>hR      -> Reset entire buffer
--   <leader>hp      -> Preview hunk (floating window)
--   <leader>hb      -> Blame line (full commit info)
--   <leader>hB      -> Toggle inline blame
--   <leader>hd      -> Diff this buffer
--   <leader>hD      -> Diff this buffer vs HEAD~
--   <leader>tb      -> Toggle git signs
--   <leader>tB      -> Toggle number highlight
--   <leader>tl      -> Toggle line highlight
--   <leader>tw      -> Toggle word diff
--   <leader>td      -> Toggle deleted lines
--   ih (operator)   -> Select hunk (inner)

-- ============================================================================
-- SNACKS.NVIM -- QoL utilities (picker, notifier, zen, indent, scroll)
-- ============================================================================
-- snacks.picker:
keyset("n", "<leader>sk", function()
    require("snacks").picker.keymaps()
end, { desc = "Search Keymaps" })
keyset("n", "<leader>sC", function()
    require("snacks").picker.commands()
end, { desc = "Search Commands" })
keyset("n", "<leader>sR", function()
    require("snacks").picker.resume()
end, { desc = "Resume Last Picker" })
keyset("n", '<leader>s"', function()
    require("snacks").picker.registers()
end, { desc = "Search Registers" })
-- snacks.notifier:
keyset("n", "<leader>un", function()
    require("snacks").notifier.hide()
end, { desc = "Dismiss Notifications" })
-- snacks.zen (distraction-free mode):
keyset("n", "<leader>uz", function()
    require("snacks").zen.toggle()
end, { desc = "Toggle Zen Mode" })
-- snacks.scroll, snacks.words, snacks.bigfile: automatic (no keymaps)
-- Indent guides: indent-blankline; scope motions/text objects: mini.indentscope.

-- ============================================================================
-- MINUET-AI.NVIM -- AI code completions via OpenRouter DeepSeek (free)
-- ============================================================================
-- Requires: OPENROUTER_API_KEY env var (free account at openrouter.ai)
-- Provider: deepseek/deepseek-v4-flash (~$0, FIM-supported)
--
-- blink.cmp integration (in plugin_configs/blink.lua):
--   - Auto-completion: minuet is in blink's default sources list
--   - Manual trigger: <A-y> in insert mode (see keymap below)
keyset("i", "<A-y>", function()
    require("blink.cmp").show()
end, { desc = "Minuet: Trigger AI Completion" })
-- Commands available:
--   :Minuet change_provider  -> Switch AI provider
--   :Minuet change_model     -> Switch AI model
--   :Minuet blink toggle     -> Toggle auto-complete on/off
--   :Minuet blink enable     -> Enable auto-complete
--   :Minuet blink disable    -> Disable auto-complete

-- ============================================================================
-- SIDEKICK.NVIM -- AI assistant using Codex CLI (ChatGPT Pro bundled)
-- ============================================================================
-- Requires Codex CLI: npm install -g @openai/codex
-- Auth: codex login (browser OAuth using ChatGPT Pro subscription, no API key)
--
-- All keymaps are registered in the lazy spec (core_plugins.lua):
--   <c-.>          -> Focus CLI terminal (any mode)
--   <leader>aa      -> Toggle Codex CLI (terminal panel, right side)
--   <leader>as      -> Select which AI CLI tool to open
--   <leader>ad      -> Detach/close current CLI session
--   <leader>at      -> Send {this} (position or selection) to Codex
--   <leader>af      -> Send current file context to Codex
--   <leader>av      -> Send visual selection to Codex (visual mode)
--   <leader>ap      -> Open prompt picker (Explain, Fix, Tests, Review, etc.)
--
-- CLI terminal keymaps (inside the Codex terminal window, config in sidekick.lua):
--   <c-b>           -> Add buffer context
--   <c-f>           -> Add file context
--   <c-p>           -> Insert prompt or context
--   q (normal mode) -> Hide terminal
--   <c-q>           -> Hide terminal
--   <c-z>           -> Blur (leave terminal, keep it running)
--
-- NES (Next Edit Suggestions) requires Copilot subscription — disabled.
