return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				luau = {
					require("formatter.filetypes.lua").stylua,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				vim.cmd.FormatWrite()
			end,
		})
	end,
}
