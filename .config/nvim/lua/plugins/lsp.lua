return {
	-- tools
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"selene",
				-- luacheck omitted: it needs luarocks/lua5.1, and selene already
				-- covers Lua linting here
				"shellcheck",
				"shfmt",
				"tailwindcss-language-server",
				"css-lsp",
			})
		end,
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			servers = {
				-- Keymaps for every server. Merged with the LazyVim defaults,
				-- so this only overrides `gd`.
				["*"] = {
					keys = {
						{
							"gd",
							function()
								-- DO NOT REUSE WINDOW
								LazyVim.pick("lsp_definitions", { reuse_win = false })()
							end,
							desc = "Goto Definition",
							has = "definition",
						},
					},
				},
				cssls = {},
				tailwindcss = {
					-- Use the git root, so Tailwind also works in monorepos and
					-- v4 projects that have no tailwind.config.* file.
					root_dir = function(bufnr, on_dir)
						on_dir(vim.fs.root(bufnr, ".git") or vim.fn.getcwd())
					end,
				},
				-- LazyVim's typescript extra runs `vtsls` (tsserver/ts_ls are disabled
				-- by it), and its defaults already match the TypeScript inlay hints
				-- that used to live here. Only the JavaScript deltas are set below.
				vtsls = {
					settings = {
						javascript = {
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					workspace_required = false,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			},
			setup = {},
		},
	},
}
