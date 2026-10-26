-- ============================================================================
-- Blink.cmp — Modern completion engine with Rust fuzzy matching
-- Replaces nvim-cmp + lsp-zero completion. All bells and whistles enabled.
-- ============================================================================

local blink = require("blink.cmp")

-- Helper: map extended LSP kind to icon text
local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈚",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰉺",
}

blink.setup({
	-- ── Keymap ──────────────────────────────────────────────────────────
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		-- Manually invoke AI completion from minuet (OpenRouter DeepSeek, free)
		["<A-y>"] = require("minuet").make_blink_map(),
	},

	-- ── Appearance ──────────────────────────────────────────────────────
	appearance = {
		-- Use 'mono' for Nerd Font Mono or 'normal' for Nerd Font
		nerd_font_variant = "mono",
	},

	-- ── Completion behavior ────────────────────────────────────────────
	completion = {
		-- Prevent prefetch on insert — avoids wasting AI API requests
		trigger = { prefetch_on_insert = false },

		-- Auto-show documentation popup
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},

		-- Inline ghost text (snippet preview / next-completion hint)
		ghost_text = {
			enabled = true,
		},

		-- Completion menu
		menu = {
			border = "rounded",
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", gap = 1 },
					{ "kind" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = kind_icons[ctx.kind]
								or ctx.kind_icon
								or ""
							-- Use nvim-web-devicons for path entries
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local ok, devicons = pcall(require, "nvim-web-devicons")
								if ok then
									local dev_icon, _ = devicons.get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							local hl = ctx.kind_hl
							-- Reuse devicon highlight for path entries
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local ok, devicons = pcall(require, "nvim-web-devicons")
								if ok then
									local _, dev_hl = devicons.get_icon(ctx.label)
									if dev_hl then
										hl = dev_hl
									end
								end
							end
							return hl
						end,
					},
				},
			},
		},

		-- List behavior: preselect first item, auto-insert on select_next
		list = {
			selection = {
				preselect = true,
				auto_insert = true,
			},
		},

		-- Auto-add brackets when accepting function completions
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
	},

	-- ── Signature help ──────────────────────────────────────────────────
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},

	-- ── Sources ─────────────────────────────────────────────────────────
	sources = {
		default = { "lsp", "path", "snippets", "buffer", "minuet" },
		-- Per-filetype overrides
		per_filetype = {
			codecompanion = { "codecompanion" },
		},
		providers = {
			-- LSP completions
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",
				score_offset = 100, -- Boost LSP results
			},
			-- Path completions
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 50,
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function()
						return vim.fn.expand("#:p:h")
					end,
					show_hidden_files_by_default = true,
				},
			},
			-- Snippets (powered by LuaSnip)
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				score_offset = 75,
			},
			-- Buffer words
			buffer = {
				name = "Buffer",
				module = "blink.cmp.sources.buffer",
				score_offset = 25,
			},
			-- Minuet AI completions (OpenRouter DeepSeek)
			-- Requires: milanglacier/minuet-ai.nvim
			minuet = {
				name = "AI (Minuet)",
				module = "minuet.blink",
				async = true,
				timeout_ms = 3000,
				score_offset = 50, -- above buffer, alongside path
			},
		},
	},

	-- ── Fuzzy matching ──────────────────────────────────────────────────
	-- Use Rust implementation for typo resistance and performance.
	-- Falls back to pure Lua if the Rust binary is unavailable.
	fuzzy = {
		implementation = "prefer_rust",
	},

	-- ── Snippets ────────────────────────────────────────────────────────
	-- Use LuaSnip as the snippet engine (required for friendly-snippets)
	snippets = {
		preset = "luasnip",
	},

	-- ── Cmdline completions ─────────────────────────────────────────────
	-- Enable completions in : and / command-line modes
	cmdline = {
		enabled = true,
		keymap = {
			preset = "default",
		},
		completion = {
			menu = {
				auto_show = true,
			},
		},
		sources = function()
			local cmd_type = vim.fn.getcmdtype()
			-- Search mode: use buffer words
			if cmd_type == "/" or cmd_type == "?" then
				return { "buffer" }
			end
			-- Command mode: use cmdline source
			if cmd_type == ":" then
				return { "cmdline" }
			end
			return {}
		end,
	},
})

-- ── LSP capabilities ────────────────────────────────────────────────
-- Set blink capabilities as default for ALL LSP servers.
-- Must be done before any vim.lsp.enable() call, which is why we
-- defer LSP server configs via lsp.setup() below.
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- ── Deferred LSP server setup ────────────────────────────────────────
-- Now that capabilities are set, configure and enable all LSP servers.
pcall(function()
	require("codesensei.core.plugin_configs.lsp").setup()
end)

-- ── Autopairs integration ────────────────────────────────────────────
-- Wire up nvim-autopairs to blink's completion accept event
pcall(function()
	require("nvim-autopairs.completion.blink").setup()
end)
