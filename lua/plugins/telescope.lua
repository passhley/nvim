return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-p>", builtin.find_files)
		vim.keymap.set("n", "<C-g>", builtin.live_grep)

		require("plenary.filetype").add_file("luau")
		require("telescope").setup({})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
