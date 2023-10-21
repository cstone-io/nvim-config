local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Core Plugins
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("nvim-lua/popup.nvim") -- An implementation of the popup API for lua

	-- Dashboard
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	})

	-- Completion Plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- Buffer completions
	use("hrsh7th/cmp-path") -- Path completions
	use("hrsh7th/cmp-nvim-lsp") -- LSP completions
	use("hrsh7th/cmp-cmdline") -- CLI completions
	use("hrsh7th/cmp-nvim-lua") -- Neovim lua completions
	use("saadparwaiz1/cmp_luasnip") -- Snippet completions
	use("windwp/nvim-autopairs") -- Autopairs, integrates with cmp

	-- Snippets
	use("L3MON4D3/LuaSnip") -- Snippet engine
	use("rafamadriz/friendly-snippets") -- Snippet library contrib

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim") -- Simple LSP installer
	use("williamboman/mason-lspconfig.nvim")
	use("mhartington/formatter.nvim") -- Format runer

	-- Formatters
	use("ckipp01/stylua-nvim") -- Lua
	use({ "prettier/vim-prettier", run = "npm i -g --frozen-lockfile --production" }) -- HTML, CSS, Typescript
	use("averms/black-nvim")

	-- Telescope (and extensions)
	use("nvim-telescope/telescope.nvim")

	-- Explorer (nvim-tree)
	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua")

	-- Buffer (bufferline)
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	-- Toggle Term
	use("akinsho/toggleterm.nvim")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("mbbill/undotree")

	-- Search / replace
	use("roobert/search-replace.nvim")
	use("kevinhwang91/nvim-hlslens")
	use("kevinhwang91/nvim-ufo")

	-- Comment
	use("numToStr/Comment.nvim")

	-- Surround
	use("kylechui/nvim-surround")

	-- GitHub (Copilot)
	use("github/copilot.vim")

	-- Git
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")

	-- Colorschemes
	use({ "sainnhe/sonokai", as = "sonokai" })
	use({ "catppuccin/nvim", as = "catppuccino" })
	use({ "Mofiqul/dracula.nvim", as = "dracula" })

	-- The Primagen plugins
	use("theprimeagen/harpoon")
end)
