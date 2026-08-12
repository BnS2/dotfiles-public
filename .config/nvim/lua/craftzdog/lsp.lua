local M = {}

function M.toggleInlayHints()
	local buf = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
end

function M.toggleAutoformat()
	require("lazyvim.util").format.toggle()
end

return M
