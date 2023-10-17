local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({
	padding = true, ---Add a space b/w comment and the line
	sticky = true, ---Whether the cursor should stay at its position
	ignore = nil, ---Lines to be ignored while (un)comment
	toggler = {
		---LHS of toggle mappings in NORMAL mode
		line = "<leader>/", ---Line-comment toggle keymap
		block = "<leader>cbb", ---Block-comment toggle keymap
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		line = "<leader>cc", ---Line-comment keymap
		block = "<leader>cb", ---Block-comment keymap
	},
	---LHS of extra mappings
	extra = {
		above = "<leader>ccO", ---Add comment on the line above
		below = "<leader>cco", ---Add comment on the line below
		eol = "<leader>cca", ---Add comment at the end of line
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
	},
	pre_hook = nil, ---Function to call before (un)comment
	post_hook = nil, ---Function to call after (un)comment
})
