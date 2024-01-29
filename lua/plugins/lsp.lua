return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()


            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            require("nvim-autopairs").setup()

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'buffer', max_item_count = 5},
                    {name = 'path', max_item_count = 3},
                    {name = 'luasnip', max_item_count = 3},
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                experimental = {
                    ghost_text = true,
                }
            })

            local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

            vim.api.nvim_create_autocmd('LspAttach', {
                group = lsp_cmds,
                desc = 'LSP actions',
                callback = function()
                    local bufmap = function(mode, lhs, rhs, des)
                        vim.keymap.set(mode, lhs, rhs, {buffer = true, desc=des})
                    end

                    bufmap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Show hover tooltip')
                    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
                    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration')
                    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation')
                    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')
                    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'Find references')
                    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature help')
                    bufmap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
                    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format text')
                    bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
                    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Open diagnostic float')
                    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Goto prev')
                    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Goto next')
                end
            })

            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'tsserver',
                    'eslint',
                    'html',
                    'cssls',
                    'omnisharp',
                    'powershell_es'
                },
                handlers = {
                    function(server)
                        lspconfig[server].setup({
                            capabilities = lsp_capabilities,
                        })
                    end,
                    ['tsserver'] = function()
                        lspconfig.tsserver.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                completions = {
                                    completeFunctionCalls = true
                                }
                            }
                        })
                    end
                }
            })
        end
    },
    {
        'neoclide/coc.nvim',
        branch = "master",
        event = "VimEnter",
    },
}
