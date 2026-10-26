-- ============================================================================
-- LSP Configuration — Neovim 0.11+ vim.lsp.config API
-- Uses blink.cmp for completions (replaces lsp-zero + nvim-cmp).
-- Format-on-save is handled by conform.nvim.
--
-- IMPORTANT: Server configs are deferred via M.setup() so blink.cmp
-- capabilities are set before any LSP server is enabled.
-- M.setup() is called from codesensei.core.plugin_configs.blink after blink.setup().
-- ============================================================================

local M = {}

-- ── Mason LSP auto-install ────────────────────────────────────────────
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"gopls",
		"ts_ls",          -- TypeScript (formerly tsserver in mason)
		"clangd",
		"pyright",
		"cssls",
		"zls",
		"astro",
		"svelte",
		"tailwindcss",
		"ruff",
		"html",
		"ols",
	},
})

-- ── Mason DAP (debuggers) ─────────────────────────────────────────────
require("mason-nvim-dap").setup({
	ensure_installed = {
		"codelldb",
		"cpptools",
		"delve",
	},
})

-- ── Mason null-ls bridge (formatters / linters outside LSP) ───────────
require("mason-null-ls").setup({
	ensure_installed = { "stylua", "jq" },
})

-- ── DAP configuration ─────────────────────────────────────────────────
local dap = require("dap")
dap.configurations.zig = {
	{
		type = "codelldb",
		request = "launch",
		name = "Launch file",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		terminal = "integrated",
	},
}

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

-- ── Global LSP keymaps (applied to EVERY LSP server via LspAttach) ────
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client == nil then
			return
		end
		local bufnr = ev.buf
		local opts = { buffer = bufnr, silent = true }

		-- Navigation
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		-- Info
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		-- Workspace actions
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- Diagnostics navigation
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		-- Highlight references on cursor hold
		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- ── M.setup() — called after blink.cmp is ready ───────────────────────
function M.setup()
	-- Lua (lua_ls)
	vim.lsp.config("lua_ls", {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
					return
				end
			end
			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
			})
		end,
		settings = { Lua = {} },
	})
	vim.lsp.enable("lua_ls")

	-- Zig (zls)
	vim.lsp.config("zls", {
		settings = { enable_autofix = true },
	})
	vim.lsp.enable("zls")

	-- Go (gopls)
	vim.lsp.config("gopls", {
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		settings = {
			gopls = { completeUnimported = true },
		},
	})
	vim.lsp.enable("gopls")

	-- HTML
	vim.lsp.config("html", {
		filetypes = { "html" },
	})
	vim.lsp.enable("html")

	-- Odin (ols)
	vim.lsp.config("ols", {
		filetypes = { "odin" },
	})
	vim.lsp.enable("ols")
end

return M
