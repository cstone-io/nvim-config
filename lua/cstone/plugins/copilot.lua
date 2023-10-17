-- Shorten function name
local keymap = vim.keymap.set

vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
keymap("i", "jj", 'copilot#Accept("<CR>")', { noremap = false, silent = true, expr = true, replace_keycodes = false })
keymap("i", "kk", "<Plug>(copilot-dismiss)", { noremap = false, silent = true })
