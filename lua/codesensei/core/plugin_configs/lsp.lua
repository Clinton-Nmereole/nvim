-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local lsp = require("lsp-zero").preset({})
require("mason-nvim-dap").setup({
	ensure_installed = {
		"codelldb",
		"cpptools",
		"delve",
	},
})

require("mason-null-ls").setup({
	ensure_installed = { "stylua", "jq", "gopls", "zls" },
})

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

lsp.ensure_installed({
	"lua_ls",
	"rust_analyzer",
	"gopls",
	"tsserver",
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
})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
	enable = true,
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["rust_analyzer"] = { "rust" },
		["gopls"] = { "go" },
		["goimports"] = { "go" },
		["black"] = { "python" },
		--    ["null_ls"] = { "python" },
		["zls"] = { "zig" },
		["prettier"] = { "html", "js", "jsx", "ts", "tsx" },
		["prettierd"] = { "html", "js", "jsx", "ts", "tsx" },
		["ols"] = { "odin" },
	},
})

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

require("lspconfig").zls.setup({
	enable_autofix = true,
})

require("lspconfig").gopls.setup({
	on_attach = lsp.on_attach(),
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			completeUnimported = true,
		},
	},
})

require("lspconfig").html.setup({
	on_attach = lsp.on_attach,
	--cmd = { "html-ls" },
	filetypes = { "html" },
})

require("lspconfig").ols.setup({
	on_attach = lsp.on_attach(),
	cmd = { "ols" },
	filetypes = { "odin" },
})

--local cmp = require("cmp")
--local cmp_action = require("lsp-zero").cmp_action()
--local cmp_format = require("lsp-zero").cmp_format({ details = true })

--[[cmp.setup({
	--Sources
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},

	mapping = {
		--Enter key confirms completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		--Ctrl + Space to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<S-Tab>"] = cmp_action.luasnip_supertab(),
	},

	--Snippets
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
			require("luasnip").lsp_expand(args.body)
			-- require("nvim_lsp").lsp_expand(args.body)
		end,
	},

	-- window
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})]]
--
