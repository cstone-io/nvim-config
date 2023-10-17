local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	auto_install = true, -- Automatically install missing parsers when entering buffer
	highlight = {
		enable = true, -- False will disable the whole extension
		disable = { "" }, -- List of languages that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } }, -- Smart indenting
	playground = {
		enable = true,
	},
})
