return {
	cmd = { "clangd", "--background-index" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(fname)
		return require("lspconfig/util").root_pattern("compile_commands.json", ".git")(fname) or vim.fn.getcwd()
	end,
	init_options = {
		clangdFileStatus = true,
	},
	settings = {
		clangd = {
			clangTidyChecks = "-*,modernize-*", -- Example to enable modernize checks with clang-tidy, customize as needed
			fallbackFlags = { "-std=c11", "-I./include", "-I./include/__lib__" }, -- Set the C standard to C11
		},
	},
}
