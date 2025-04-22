require("config.lazy")

-- vim.lsp.enable('pyright')
-- vim.lsp.enable('lua_ls')

local call = vim.call
local cmd = vim.cmd

vim.opt.compatible = false
vim.cmd("syntax on")
vim.opt.background = "dark"
vim.cmd([[highlight ColorColumn ctermbg=0 guibg=lightgrey]])
vim.cmd([[colorscheme PaperColorSlim]])
--vim.opt.fileformat = "unix"
vim.opt.smartcase = true
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.guicursor = "i:block"
vim.opt.cursorline = true
vim.opt.confirm = true
-- maybe only set for md files
--vim.opt.textwidth=80
vim.opt.pumheight = 5
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:1"
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = { { path = "~/todo.md", syntax = "markdown" }, { path = "~/temp.md" } }
vim.g.vimwiki_folding = "expr"
vim.treesitter.language.register("markdown", "vimwiki")

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

-- execute lua with helpful keybinds
vim.keymap.set("n", "<Space><Space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<Space>x", ":.lua<CR>")
vim.keymap.set("v", "<Space>x", ":lua<CR>")

vim.g.mapleader = " "

function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map("n", shortcut, command)
end

function imap(shortcut, command)
	map("i", shortcut, command)
end

function vmap(shortcut, command)
	map("v", shortcut, command)
end

vmap("<Leader>y", '"+y')
vmap("<Leader>d", '"+d')
nmap("<Leader>p", '"+p')
nmap("<Leader>P", '"+P')
vmap("<Leader>p", '"+p')
vmap("<Leader>P", '"+P')

-- close buffers nicely
nmap("<C-l>", ":bd<Cr>")

nmap("<tab>", ":bn<CR>")
nmap("<S-tab>", ":bp<CR>")
nmap("<Leader>n", ":cn<CR>")
nmap("<Leader>p", ":cp<CR>")
nmap("<Leader>cl", ":ccl<CR>")

nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nmap("<leader>fr", "<cmd>Telescope resume<cr>")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Override crappy angularhtml formatting
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.html",
	callback = function(args)
		command = "set filetype=html"
	end,
})

vim.filetype.add({
	extension = {
		html = "html",
	},
	pattern = {
		["*.html"] = "html",
	},
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>fa", ":0,$!yapf<Cr>", opts)
		vim.keymap.set("n", "<space>fi", ":0,$!isort -<Cr>", opts)
	end,
})

-- vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
-- vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
