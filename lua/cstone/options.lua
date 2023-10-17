
-- language specific tab settings
vim.cmd [[
  autocmd FileType python,bash,java,rust setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
]]

local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  colorcolumn = "80",
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  cursorline = true,                       -- highlight the current line
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  guicursor = "",
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  hlsearch = false,                        -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  incsearch = true,
  linebreak = true,                        -- companion to wrap, don't split words
  mouse = "a",                             -- allow the mouse to be used in neovim
  nu = true,
  number = true,                           -- set numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  pumheight = 10,                          -- pop up menu height
  relativenumber = true,                   -- set relative numbered lines
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 50,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  softtabstop = 2,
  tabstop = 2,                             -- insert 2 spaces for a tab
  wrap = false,                            -- display lines as one long line
  whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line


}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir",
vim.opt.isfname:append("@-@")
-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
