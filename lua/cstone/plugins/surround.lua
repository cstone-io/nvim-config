local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
	return
end

surround.setup({
	keymaps = {
		insert = "<C-g>s",
		insert_line = "<C-g>S",
		normal = "ys",
		normal_cur = "yss",
		normal_line = "yS",
		normal_cur_line = "ySS",
		visual = "S",
		visual_line = "gS",
		delete = "ds",
		change = "cs",
		change_line = "cS",
	},
	aliases = {
		["a"] = ">",
		["b"] = "}",
		["p"] = ")",
		["s"] = "]",
		["q"] = "'",
		["Q"] = '"',
	},
	highlight = {
		duration = 0,
	},
	move_cursor = "begin",
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>sw", "<Plug>(nvim-surround-normal)iw", opts)
keymap("n", "<leader>sW", "<Plug>(nvim-surround-normal)iW", opts)
keymap("n", "<leader>sl", "<Plug>(nvim-surround-normal-cur)", opts)
keymap("n", "<leader>sc", "<Plug>(nvim-surround-change)", opts)
keymap("n", "<leader>sd", "<Plug>(nvim-surround-delete)", opts)

keymap("v", "<leader>s", "<Plug>(nvim-surround-visual)", opts)
