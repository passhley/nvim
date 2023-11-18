local locate_config = require("pashley/utils/locate_config")
local project_file_names = { "default", "dev", "test", "bundle" }

-- Append '.project.json' to each file name
for index, name in ipairs(project_file_names) do
	project_file_names[index] = name .. ".project.json"
end

return function()
	return locate_config(project_file_names)
end
