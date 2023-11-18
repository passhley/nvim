local get_rojo_projects = require("pashley/utils/get_rojo_projects")
local locate_config = require("pashley/utils/locate_config")

return {
	"lopi-py/luau-lsp.nvim",
	config = function()
		require("luau-lsp").treesitter()

		local function set_keymap(ev)
			local function map_key(key, callback)
				vim.keymap.set("n", key, callback, { buffer = ev.buf })
			end

			map_key("<leader>ca", vim.lsp.buf.code_action)
			map_key("gd", vim.lsp.buf.definition)
			map_key("gt", vim.lsp.buf.type_definition)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspKeymap", {}),
			callback = set_keymap,
		})

		local aliases = {}
		local darklua_config = locate_config({ ".darklua.json" })[1]
		local string_require_mode = darklua_config ~= nil

		vim.notify(
			"StringRequireMode: " .. tostring(string_require_mode),
			vim.log.levels.INFO,
			{ title = "LUAU LSP" }
		)

		local project_file = get_rojo_projects()[1]
		local roblox_mode = project_file ~= nil

		if darklua_config then
			local fd = io.open(darklua_config)
			local content

			if fd then
				content = vim.json.decode(fd:read("*a"), {
					luanil = {
						object = true,
						array = true,
					},
				})

				fd:close()
			end

			if content then
				local sources = {}

				if content.bundle then
					sources = vim.tbl_extend(
						"keep",
						sources,
						content.bundle.require_mode.sources
					)
				elseif content.rules then
					for _, rule in ipairs(content.rules) do
						if type(rule) == "table" then
							if rule.rule == "convert_require" then
								sources = vim.tbl_extend(
									"keep",
									sources,
									rule.current.sources
								)
								break
							end
						end
					end
				end

				if sources then
					for alias, dir in pairs(sources) do
						dir = dir:gsub("^./", "$PWD/")
						aliases[alias .. "/"] = vim.fs.normalize(dir)
					end
				end
			end
		end

		require("luau-lsp").setup({
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					["luau-lsp"] = {
						require = {
							mode = "relativeToFile",
							directoryAliases = aliases,
						},
						completion = {
							imports = {
								enabled = true,
								suggestServices = true,
								suggestRequires = not string_require_mode,
							},
						},
					},
				},
			},
			sourcemap = {
				enabled = true,
			},
			types = {
				roblox = true,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
}
