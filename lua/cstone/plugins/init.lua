local function req(file)
	require("cstone.plugins." .. file)
end

-- Require all modules here
-- Comment out the module for a quick and easy disable
req("autopairs")
req("bufferline")
req("cmp")
req("comment")
req("devicons")
req("formatter")
req("fugitive")
req("gitsigns")
req("harpoon")
req("nvim-tree")
req("prettier")
req("search-replace")
req("surround")
req("telescope")
req("toggleterm")
req("treesitter")
req("undotree")
