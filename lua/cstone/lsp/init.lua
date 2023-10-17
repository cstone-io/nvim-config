local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

local function req(file)
	require("cstone.lsp." .. file)
end

req("mason")
req("handlers")
req("python")
