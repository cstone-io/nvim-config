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

-- Set up the filetype
vim.filetype.add({
	pattern = {
		["^\\.env"] = "dotenv", -- This should match any file starting with .env
	},
})

-- Define a function to set up the custom highlighting
local function set_dotenv_highlighting()
	if vim.b.current_syntax then
		return
	end

	-- Define the syntax matching
	vim.cmd([[
    syn match envComment '^#.*'
    syn match envVariableUnassigned "^\<\h\w*$"
    syn match envVariable "^\<\h\w*\ze=" nextgroup=envVarAssign
    syn match envVarAssign contained "=" nextgroup=envVar,envQuotedVarOpen,envSpace
    syn match envVar contained "\h\w*"
    syn match envSpace contained "\s\+" nextgroup=envQuotedVarOpen
    syn match envQuotedVarOpen contained "[\"']"
    syn match envSpace "\s$"
    syn match envQuotedVarClose "[\"']$"
  ]])

	-- Assign the syntax highlighting
	vim.api.nvim_set_hl(0, "envComment", { link = "Comment" })
	vim.api.nvim_set_hl(0, "envVariableUnassigned", { link = "Error" })
	vim.api.nvim_set_hl(0, "envVariable", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "envVarAssign", { link = "Operator" })
	vim.api.nvim_set_hl(0, "envSpace", { link = "Error" })
	vim.api.nvim_set_hl(0, "envQuotedVarOpen", { link = "Error" })
	vim.api.nvim_set_hl(0, "envQuotedVarClose", { link = "Error" })

	-- Set the syntax for the buffer
	vim.b.current_syntax = "dotenv"
end

-- Run the function when opening .env files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = ".env*",
	callback = set_dotenv_highlighting,
})

-- Recognize Templ files
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
