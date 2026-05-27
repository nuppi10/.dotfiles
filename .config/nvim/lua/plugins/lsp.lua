return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- Enable status updates for LSP loading
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls", 
                "tailwindcss",
                "zls",
            },
            handlers = {
                -- Default handler using the modern native API
                function(server_name)
                    vim.lsp.config(server_name, { capabilities = capabilities })
                    vim.lsp.enable(server_name)
                end,

                ["lua_ls"] = function()
                    vim.lsp.config("lua_ls", {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                },
                            },
                        },
                    })
                    vim.lsp.enable("lua_ls")
                end,

                ["ts_ls"] = function()
                    -- Note: util.root_pattern is no longer strictly required as nvim-lspconfig 
                    -- populates standard root_markers into vim.lsp.config automatically
                    vim.lsp.config("ts_ls", {
                        capabilities = capabilities,
                        settings = {
                            javascript = {
                                inlayHints = { includeInlayParameterNameHints = "all" }
                            },
                            typescript = {
                                inlayHints = { includeInlayParameterNameHints = "all" }
                            }
                        }
                    })
                    vim.lsp.enable("ts_ls")
                end,

                ["zls"] = function()
                    vim.lsp.config("zls", {
                        capabilities = capabilities,
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.lsp.enable("zls")
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
            }
        })

        -- Godot GDScript LSP setup (Bypasses Mason, using native config/enable)
        vim.lsp.config("gdscript", {
            capabilities = capabilities,
            name = "godot",
            cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        })
        vim.lsp.enable("gdscript")

        -- Setup completion (nvim-cmp)
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- Snippet expansion
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- Snippets
            }, {
                { name = "buffer" },
            }),
        })

        -- Improve LSP diagnostic display
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
