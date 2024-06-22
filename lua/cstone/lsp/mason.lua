local servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"clangd",
	"gopls",
	"templ",
	"htmx-lsp",
	"tailwindcss",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "",
			package_pending = "󰇘",
			package_uninstalled = "",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

local handlers = require("cstone.lsp.handlers")
if not handlers.on_attach or not handlers.capabilities then
	return
end

for _, server in pairs(servers) do
	opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	server = vim.split(server, "@")[1]

	-- Haskell is weird...
	if server == "haskell-language-server" then
		server = "hls"
	end

	local require_ok, conf_opts = pcall(require, "cstone.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	-- htmx-lsp is a custom server
	local htmx_ok, htmx = pcall(require, "htmx")
	if htmx_ok then
		vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = htmx.templ_format })
	end

	if server == "htmx-lsp" or server == "html" then
		opts = vim.tbl_deep_extend("force", {
			filetypes = { "html", "templ" },
		}, opts)
	end

	if server == "tailwindcss" then
		opts = vim.tbl_deep_extend("force", {
			filetypes = { "templ", "html", "javascript", "typescript", "react" },
			init_options = {
				userLanguages = {
					templ = "html",
				},
			},
		}, opts)
	end

	lspconfig[server].setup(opts)
end
