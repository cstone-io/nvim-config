local status_ok, search = pcall(require, "search-replace")
if not status_ok then
	return
end

search.setup({
	default_replace_single_buffer_options = "gcI",
	default_replace_multi_buffer_options = "egcI",
})

-- Custom Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>rw", ":SearchReplaceSingleBufferCWord<cr>", opts)
keymap("n", "<leader>rW", ":SearchReplaceSingleBufferCWORD<cr>", opts)
keymap("n", "<leader>ro", ":SearchReplaceSingleBufferOpen<cr>", opts)

keymap("v", "<leader>r", ":SearchReplaceWithinVisualSelection<cr>", opts)
