local default = "dracula"

function Recolor(color)
  color = color or default
  status_ok, _ = pcall(vim.cmd, "colorscheme " .. color)
  if not status_ok then
    return
  end

  vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
  vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
  vim.api.nvim_set_hl(0, "Pmenu", {bg = "none", fg = "#ffffff"})
  vim.api.nvim_set_hl(0, "PmenuSel", {bg = "none", fg = "#ffffff"})
end

Recolor(default)
