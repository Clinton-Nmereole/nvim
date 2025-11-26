local themes = require("codesensei.core.themes")
local M = {
	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("telescope").setup()
		end,
	},

	--Treesitter stuff
	{
		"nvim-treesitter/nvim-treesitter",
		--event = { "BufReadPre", "BufRead", "BufNewFile" },
		--cmd = { ":TSInstall", ":TSModuleInfo", ":TSBufEnable", ":TSBufDisable" },
		build = { ":TSUpdate", ":TSInstall zig", ":TSEnable highlight zig" },
		--run = "TSUpdate",
		config = function()
			require("codesensei.core.plugin_configs.treesitter")
		end,
	},
	{
		"nvim-treesitter/playground",
	},

	--undotree
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		init = function()
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_SplitWidth = 22
		end,
	},

	--web dev icons and nvim-tree
	{
		"ryanoasis/vim-devicons",
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		--tag = "nightly" -- optional, updated every week. (see issue #1193)
	},

	--Harpoon for file navigation
	{
		"ThePrimeagen/harpoon",
		lazy = true,
	},

	--LSP Zero
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			--LSP support
			"neovim/nvim-lspconfig",

			{
				"nvimtools/none-ls.nvim",
			},

			--null-ls
			"jay-babu/mason-null-ls.nvim",

			--Autocompletionsplugins
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",

			--Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"honza/vim-snippets",
		},
	},

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", auto_insert = true },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "fira",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = true },
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
					border = "rounded",
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	--None-ls

	--Lsp-Lines
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup({
				vim.diagnostic.config({
					virtual_text = true,
					virtual_lines = true,
				}),
			})
		end,
	},

	--[[Mason-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},]]
	--

	--indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = { char = "¦" },
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
	},

	{
		"glepnir/lspsaga.nvim",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opt = true,
	},

	--Debbugger
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		lazy = true,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opt = {
			handlers = {},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "gopls" },
		},
	},
	--Python debugger
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dap-python").setup()
		end,
		lazy = false,
	},
	--Go Debbugger
	{
		"dreamsofcode-io/nvim-dap-go",
		ft = "go",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
		lazy = true,
	},

	-- Notify
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify")
		end,
		init = function()
			vim.notify = require("notify")
		end,
	},

	--Auto pairs
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			--setup cmp for autopairs
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	--bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup()
		end,
	},

	--Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					hover = {
						enabled = true,
					},
					signature = {
						enabled = true,
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
			})
		end,
	},

	--[[
    --Miscellaneous
    --]]
	--
	--
	--Alpha-nvim
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},

	--Go language support
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
	},

	--Nim language support
	{
		"alaviss/nim.nvim",
		ft = "nim",
	},

	--Odin language support
	{
		"Tetralux/odin.vim",
		ft = "odin",
	},

	--Rust language support
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "VonHeikemen/lsp-zero.nvim",
		config = function()
			require("rust-tools").setup()
		end,
	},

	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},

	--Astrojs support
	{
		"wuelnerdotexe/vim-astro",
		ft = "astro",
	},

	--[[Zig language support
	{
		"ziglang/zig.vim",
		event = { "BufReadPre", "BufRead", "BufNewFile" },
		init = function()
			vim.g.zig_fmt_autosave = 1
		end,
		ft = "zig",
		lazy = false,
	},]]
	--

	-- Spectre search and replace
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},

	--Codeium for AI suggestions
	{
		"Exafunction/codeium.vim",
		lazy = false,
	},

	-- add this to the file where you setup your other plugins:
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<A-f>", neocodeium.accept)
		end,
	},

	--[[Hardtime for vim suggestions
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},]]
	--

	--LazyGit
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = "nvim-lua/plenary.nvim",
		init = function()
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_floating_window_scaling_factor = 0.9
			vim.g.lazygit_floating_window_border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
			vim.g.lazygit_use_neovim_remote = 1
			vim.g.lazygit_floating_window_use_plenary = 0
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	--Todo Comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	--Plugin that remembers the last color theme called with ":colorscheme"
	{
		"raddari/last-color.nvim",
		lazy = false,
		priority = 1000,
	},

	--Latex support
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.compiler_method = "tex-live"
			vim.g.maplocalleader = ","
		end,
	},
	-- Transparent background for neovim
	{
		"tribela/vim-transparent",
	},

	--Neorg plugin
	{
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
					["core.keybinds"] = {
						config = {
							default_keybindings = true,
						},
					},
				},
			})
		end,
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opt = {},
	},

	--barbacue
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},

	--colorizer
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	--Conform
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				go = { "gofumpt", "goimports", "goimports-reviser" },
				html = { "prettier", "prettierd" },
			},

			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	--Nvim lint
	{
		"mfussenegger/nvim-lint",
	},

	--LspKind
	{ "onsails/lspkind.nvim" },

	--[[ Code COmpanion AI
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"saghen/blink.cmp",
				opts = {
					sources = {
						default = { "codecompanion" },
						providers = {
							codecompanion = {
								name = "CodeCompanion",
								module = "codecompanion.providers.completion.blink",
								enabled = true,
							},
						},
					},
				},
			},
		},
		config = true,
	},
    ]]
	--

	--Themes
	themes,
}

return M
