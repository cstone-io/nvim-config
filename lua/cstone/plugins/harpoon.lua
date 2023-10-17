local mark_status_ok, mark = pcall(require, "harpoon.mark")
if not mark_status_ok then
  return
end

local ui_status_ok, ui = pcall(require, "harpoon.ui")
if not ui_status_ok then
  return
end

local keymap = vim.keymap.set

keymap("n", "<leader>ha", mark.add_file)
keymap("n", "<leader>hm", ui.toggle_quick_menu)

local function nav(index)
  return function()
    ui.nav_file(index)
  end
end

keymap("n", "<leader>1", nav(1))
keymap("n", "<leader>2", nav(2))
keymap("n", "<leader>3", nav(3))
keymap("n", "<leader>4", nav(4))
keymap("n", "<leader>5", nav(5))
keymap("n", "<leader>6", nav(6))
keymap("n", "<leader>7", nav(7))
keymap("n", "<leader>8", nav(8))
keymap("n", "<leader>9", nav(9))

