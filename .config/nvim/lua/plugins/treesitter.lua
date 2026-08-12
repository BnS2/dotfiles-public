return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- Extra parsers on top of the LazyVim defaults (`ensure_installed` is
		-- opts_extend'ed by LazyVim, so this list is appended, not replacing).
		opts = {
			ensure_installed = {
				"astro",
				"cmake",
				"cpp",
				"css",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"http",
				"java",
				"php",
				"rust",
				"scss",
				"sql",
				"svelte",
			},
		},
		init = function()
			-- MDX: highlight with the markdown parser (filetype is registered in
			-- lua/config/options.lua)
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},
}
