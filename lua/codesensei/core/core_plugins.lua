local themes = require("codesensei.core.themes")
local M = {
    --Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("telescope").setup()
        end

    },

    --Treesitter stuff
    {
        "nvim-treesitter/nvim-treesitter",
        --event = { "BufReadPre", "BufRead", "BufNewFile" },
        --cmd = { ":TSInstall", ":TSModuleInfo", ":TSBufEnable", ":TSBufDisable" },
        build = {":TSUpdate", ":TSInstall zig", ":TSEnable highlight zig"},
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
        end
    },


    --web dev icons and nvim-tree
    {
        "ryanoasis/vim-devicons"
    },
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        --tag = "nightly" -- optional, updated every week. (see issue #1193)
    },

    --Harpoon for file navigation
    {
        "ThePrimeagen/harpoon",
        lazy = true
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
        }
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
        "numToStr/Comment.nvim"
    },

    {
        "glepnir/lspsaga.nvim"
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opt = true,
    },


    --Debbugger
    {
        "mfussenegger/nvim-dap",
        lazy = true
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        lazy = true
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
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
        lazy = true
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opt = {
            handlers = {},
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
        lazy = false
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
        lazy = true

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
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = true,
                }
            })
        end
    },

    --[[
    --Miscellaneous
    --]] --
    --
    --Alpha-nvim
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
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
        end
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

    --Zig language support
    {
        "ziglang/zig.vim",
        event = { "BufReadPre", "BufRead", "BufNewFile" },
        init = function()
            vim.g.zig_fmt_autosave = 1
        end,
        ft = "zig",
        lazy = false,
    },

    -- Spectre search and replace
    {
        "nvim-pack/nvim-spectre",
        config = function()
            require("spectre").setup()
        end
    },

    --Codeium for AI suggestions
    {
        "Exafunction/codeium.vim",
        lazy = false,
    },

    --Hardtime for vim suggestions
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    },
    

    --LazyGit
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        dependencies = "nvim-lua/plenary.nvim",
        init = function()
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            vim.g.lazygit_floating_window_border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
            vim.g.lazygit_use_neovim_remote = 1
            vim.g.lazygit_floating_window_use_plenary = 0
        end
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
        }
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
        priority = 1000
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
        end
    },
    -- Transparent background for neovim
    {
        "tribela/vim-transparent"
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
                        }
                    }
                }
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
        end
    },

    --Conform
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end
    },

    --Themes
    themes,

}

return M
