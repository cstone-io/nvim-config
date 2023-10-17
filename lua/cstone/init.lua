local function req(file)
	require("cstone." .. file)
end

-- some plugins require python, let them know to use base environment
vim.g.python3_host_prog = "/home/cstone/miniconda3/bin/python"

-- Define the function that combines :w and :so
vim.cmd([[
  function! SaveAndSource()
    write
    source %
  endfunction
]])
-- Create the :W command that calls the above function
vim.cmd("command! W call SaveAndSource()")

req("colorscheme")
req("keymap")
req("options")
req("packer")
req("plugins")
req("lsp")
