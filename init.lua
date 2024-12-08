local call = vim.call
local cmd = vim.cmd
local Plug = vim.fn['plug#']
local PATH = "~/.local/share/nvim/plugged"

call('plug#begin', PATH)
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'mfussenegger/nvim-lint'
	Plug 'vimwiki/vimwiki'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'airblade/vim-gitgutter'
	Plug 'jreybert/vimagit'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
---	Plug 'junegunn/goyo.vim'
	Plug 'tpope/vim-surround'
	Plug 'mattn/emmet-vim'
	Plug('nvim-treesitter/nvim-treesitter', {['do']= vim.fn[':TSUpdate']})
	Plug 'preservim/vimux'
	Plug 'nvim-treesitter/nvim-treesitter-context'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug('L3MON4D3/LuaSnip', {tag='v2.*', ['do']= vim.fn['make install_jsregexp']})
	Plug 'stevearc/conform.nvim'
call'plug#end'

vim.cmd[[colorscheme PaperColor]]

vim.opt.fileformat = "unix"
vim.opt.smartcase = true
vim.opt.background="dark"
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.guicursor="i:block"
vim.opt.cursorline = true
vim.opt.confirm = true
vim.opt.textwidth=80
vim.opt.pumheight=5
vim.g.vimwiki_folding="expr"
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab= true
vim.opt.signcolumn = "yes:1"

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

vmap("<Leader>y", '"+y')
vmap("<Leader>d", "\"+d")
nmap("<Leader>p", "\"+p")
nmap("<Leader>P", "\"+P")
vmap("<Leader>p", "\"+p")
vmap("<Leader>P", "\"+P")

nmap("<tab>", ":bn<CR>")
nmap("<S-tab>", ":bp<CR>")
nmap("<Leader>n", ":cn<CR>")
nmap("<Leader>p", ":cp<CR>")

nmap("<leader>ff", "<cmd>Telescope find_files theme=ivy layout_config={width=120}<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep theme=ivy layout_config={width=120}<cr>")
nmap("<leader>fb", "<cmd>Telescope buffers theme=ivy layout_config={width=120}<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags theme=ivy layout_config={width=120}<cr>")
nmap("<leader>fr", "<cmd>Telescope resume<cr>")

nmap("<leader>gn", "<Plug>(GitGutterNextHunk)")
nmap("<leader>gp", "<Plug>(GitGutterPrevHunk)")
nmap("<leader>ga", "<Plug>(GitGutterStageHunk)")
nmap("<leader>gu", "<Plug>(GitGutterUndoHunk)")

--- nmap <silent> gd <Plug>(coc-definition)
--- nmap <silent> gy <Plug>(coc-type-definition)
--- nmap <silent> gi <Plug>(coc-implementation)
--- nmap <silent> gr <Plug>(coc-references)

--- nnoremap <Leader>jj :call CocAction('diagnosticNext')<CR>
--- nnoremap <Leader>kk :call CocAction('diagnosticPrevious')<CR>

--- vim.g.goyo_width = 90


require("mason").setup()
require("mason-lspconfig").setup()

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.ruff_lsp.setup{}

lspconfig.clangd.setup{}

lspconfig.pyright.setup {
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
                typeCheckingMode = 'off'
            }
        }
    }
} 
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Python
-- require("lspconfig").pyright.setup {
  -- handlers = handlers,
  -- capabilities = capabilities,
  -- on_attach = function(client, bufnr)
    -- require 'illuminate'.on_attach(client)
    -- navic.attach(client, bufnr)
    -- client.server_capabilities.completionProvider = false
    -- client.server_capabilities.hoverProvider = false
    -- client.server_capabilities.definitionProvider = false
    -- client.server_capabilities.rename = false
    -- client.server_capabilities.signature_help = false
  -- end
 -- }


require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "yapf" },
        -- Use a sub-list to run only the first available formatter
        -- javascript = { { "prettierd", "prettier" } },
    },
})

vim.keymap.set('', '<leader>fb', function ()
  require("conform").format({lsp_fallback = true })
end)



local cmp = require'cmp'

cmp.setup({
snippet = {
-- REQUIRED - you must specify a snippet engine
expand = function(args)
--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
end,
},
window = {
completion = cmp.config.window.bordered(),
documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
['<C-b>'] = cmp.mapping.scroll_docs(-4),
['<C-f>'] = cmp.mapping.scroll_docs(4),
['<C-Space>'] = cmp.mapping.complete(),
['<C-e>'] = cmp.mapping.abort(),
['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
{ name = 'nvim_lsp' },
-- { name = 'vsnip' }, -- For vsnip users.
{ name = 'luasnip' }, -- For luasnip users.
-- { name = 'ultisnips' }, -- For ultisnips users.
-- { name = 'snippy' }, -- For snippy users.
}, {
{ name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
}, {
{ name = 'buffer' },
})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
{ name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
{ name = 'path' }
}, {
{ name = 'cmdline' }
})
})

require("luasnip.loaders.from_vscode").lazy_load()

require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.9, height = 0.9 },
      horizontal = { width = 0.75 },
      dropdown = { width = 0.9, height = 0.9 },
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  -- other configuration values here
})


require('nvim-treesitter.configs').setup {
-- A list of parser names, or "all"
ensure_installed = { "c", "lua", "rust", "markdown" },

-- Install parsers synchronously (only applied to `ensure_installed`)
sync_install = false,

-- Automatically install missing parsers when entering buffer
auto_install = true,

-- List of parsers to ignore installing (for "all")
ignore_install = { },

---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

highlight = {
-- `false` will disable the whole extension
enable = true,

-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
-- the name of the parser)
-- list of language that will be disabled
disable = { "rust"},

-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- Instead of true it can also be a list of languages
additional_vim_regex_highlighting = false,
},
}

require('nvim-web-devicons').setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'papercolor_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}




