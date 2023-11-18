return {
	"theprimeagen/harpoon",
	config = function()
		require("harpoon").setup()

		local ui = require("harpoon.ui")
		local mark = require("harpoon.mark")
		local term = require("harpoon.term")

		local function nav_file(number)
			return function()
				ui.nav_file(number)
			end
		end

		local function go_to_term(number)
			return function()
				term.gotoTerminal(number)
			end
		end

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)
		vim.keymap.set("n", "<leader>1", nav_file(1))
		vim.keymap.set("n", "<leader>2", nav_file(2))
		vim.keymap.set("n", "<leader>3", nav_file(3))
		vim.keymap.set("n", "<leader>4", nav_file(4))
		vim.keymap.set("n", "<leader>5", nav_file(5))
		vim.keymap.set("n", "<leader>t1", go_to_term(1))
		vim.keymap.set("n", "<leader>t2", go_to_term(2))
		vim.keymap.set("n", "<leader>t3", go_to_term(3))
		vim.keymap.set("n", "<leader>t4", go_to_term(4))
		vim.keymap.set("n", "<leader>t5", go_to_term(5))
	end,
}
