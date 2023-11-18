local function locate_config(names)
	return vim.fs.find(names, {
		path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
		stop = vim.loop.os_homedir(),
		upward = true,
	})
end

return locate_config
