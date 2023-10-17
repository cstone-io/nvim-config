local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- Constants for constructing the Python path
local CONDA_BASE_PATH = os.getenv("HOME") .. "/miniconda3/envs/"
local PYTHON_SUFFIX = "/bin/python"

-- Function to get the Python executable path for a given Conda environment
local function get_python_path_for_conda_env(env_name)
	return CONDA_BASE_PATH .. env_name .. PYTHON_SUFFIX
end

local M = {}

function M.set_lsp_for_conda_env(env_name)
	local python_path = get_python_path_for_conda_env(env_name)

	-- Configure the LSP server with the detected Python path
	lspconfig.pyright.setup({
		on_attach = function(client, bufnr)
			-- Other on_attach logic...
		end,
		settings = {
			python = {
				pythonPath = python_path,
			},
		},
	})

	-- Restart the LSP client for the current buffer
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.buf_get_clients(bufnr)

	for _, client in ipairs(clients) do
		if client.name == "pyright" then
			client.stop()
			client.start()
			break
		end
	end

	-- Print a message to indicate the change
	vim.cmd(string.format("echo 'Switched to Conda environment: %s'", env_name))
end

-- expose as a vim command
vim.cmd([[ command! -nargs=1 SetCondaEnv lua require('cstone.lsp.python').set_lsp_for_conda_env(<f-args>) ]])

return M
