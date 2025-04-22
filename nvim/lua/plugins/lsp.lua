
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("lspconfig").pyright.setup{
                on_attach = on_attach,
                settings = {
                    pyright = {
                        autoImportCompletion = true,
                    },
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = 'openFilesOnly',
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = 'off',
                            diagnosticSeverityOverrides = {
                                reportMissingModuleSource = false,
                                reportUndefinedVariable = false,
                                reportWildcardImportFromLibrary = false,
                            }
                        }
                    }
                }
            }
            require("lspconfig").lua_ls.setup{
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT"
                        }
                    }
                }
            }

        end,
    },
    -- spawns linters based on LSP
    {
        'mfussenegger/nvim-lint'
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "yapf" },
                    -- You can customize some of the format options for the filetype (:help conform.format)
                    -- rust = { "rustfmt", lsp_format = "fallback" },
                    -- Conform will run the first available formatter
                    -- javascript = { "prettierd", "prettier", stop_after_first = true },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
        end,
    }
}
