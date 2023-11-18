vim.g.netrw_banner = 0
vim.filetype.add({
	extension = {
		luau = "luau",
	},
})

require("pashley.remap")
require("pashley.lazy")
require("pashley.set")
