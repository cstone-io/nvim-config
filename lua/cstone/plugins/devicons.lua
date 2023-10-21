local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
	return
end

local original_get_icon = devicons.get_icon

local function get_custom_ext(name)
	if
		name:match("^docker%-compose%.yml$")
		or name:match("^docker%-compose%.yaml$")
		or name:match("^docker%-compose%..+%.yml$")
		or name:match("^docker%-compose%..+%.yaml$")
	then
		return "dockercompose"
	elseif name:find("^Dockerfile%..*$") then
		return "dockerfile"
	elseif name:find("^.env%..*$") then
		return "envfile"
	elseif name:find("^.+%.yaml$") or name:find("^.+%.yml$") then
		return "yaml"
	end
	return name:match("^.*%.(.*)$") or ""
end

devicons.get_icon = function(name, ext, opts)
	return original_get_icon(name, get_custom_ext(name) or ext, opts)
end

devicons.setup({
	override = {
		sh = {
			icon = "",
			color = "#31e04f",
			name = "Zsh",
		},
		dockercompose = {
			icon = "󰡨",
			color = "#c76363",
			name = "DockerCompose",
		},
		dockerfile = {
			icon = "󰡨",
			color = "#3146e0",
			name = "Dockerfile",
		},
		envfile = {
			icon = "",
			color = "#6f747a",
			name = "Environment",
		},
		log = {
			icon = "",
			color = "#81e043",
			name = "Log",
		},
		yaml = {
			icon = "",
			color = "#b553db",
			name = "Yaml",
		},
		bak = {
			icon = "󰁯",
			color = "#ccccb4",
			name = "Backup",
		},
	},
	color_icons = true,
	default = true,
	strict = false,
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore",
		},
		[".gitmodules"] = {
			icon = "",
			color = "#0427c4",
			name = "Gitmodules",
		},
	},
})
