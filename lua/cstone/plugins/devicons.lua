local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
	return
end

local colors = {
	teal = "#33a8c7",
	turquoise = "#52e3e1",
	lime = "#a0e426",
	lemon = "#fdf148",
	orange = "#ffab00",
	salmon = "#f77976",
	magenta = "#f050ae",
	lilac = "#d883ff",
	lavender = "#9336fd",
	quartz = "#f8f9fa",
	marble = "#dee2e6",
	slate = "#adb5bd",
}

local custom_patterns = {
	first_priority = {
		cmake = {
			patterns = { "^CMakeLists%.txt$", "^.*%.cmake$", "^Makefile$" },
			icon = "",
			color = colors.lemon,
			name = "CMake",
		},
		dockercompose = {
			patterns = {
				"^docker%-compose%.yml$",
				"^docker%-compose%.yaml$",
				"^docker%-compose%..*%.yml$",
				"^docker%-compose%..*%.yaml$",
			},
			icon = "󰡨",
			color = colors.magenta,
			name = "DockerCompose",
		},
		eslint = {
			patterns = { "^%.eslint.*$" },
			icon = "",
			color = colors.lilac,
			name = "ESLint",
		},
		git = {
			patterns = { "^%.gitignore$", "^%.gitmodules$" },
			icon = "",
			color = colors.orange,
			name = "Gitignore",
		},
		gosum = {
			patterns = { "^go%.sum$" },
			icon = "",
			color = colors.slate,
			name = "GoSum",
		},
		prettier = {
			patterns = { "^%.prettier.*$" },
			icon = "",
			color = colors.lemon,
			name = "Prettier",
		},
		readme = {
			patterns = { "^README%.md$" },
			icon = "",
			color = colors.lilac,
			name = "README",
		},
		requirements = {
			patterns = { "^requirements%.txt$", "^package%.json$", "^go%.mod$" },
			icon = "",
			color = colors.salmon,
			name = "Requirements",
		},
	},
	second_priority = {
		bak = {
			patterns = { "^.*%.bak$" },
			icon = "󰁯",
			color = colors.slate,
			name = "Backup",
		},
		bash = {
			patterns = { "^.+%.sh$" },
			icon = "",
			color = colors.marble,
			name = "Zsh",
		},
		clang = {
			patterns = { "^%.clang.*$" },
			icon = "",
			color = colors.turquoise,
			name = "Clangfile",
		},
		dockerfile = {
			patterns = { "^Dockerfile.*$" },
			icon = "󰡨",
			color = colors.teal,
			name = "Dockerfile",
		},
		dotenv = {
			patterns = { "^%.env.*$" },
			icon = "",
			color = colors.lime,
			name = "Environment",
		},
		glsl = {
			patterns = { "^.*%.glsl$" },
			icon = "󰯿",
			color = colors.lemon,
			name = "OpenGL",
		},
		go = {
			patterns = { "^.*%.go$" },
			icon = "󰊭",
			color = colors.turquoise,
			name = "Go",
		},
		log = {
			patterns = { "^.*%.log$" },
			icon = "",
			color = colors.marble,
			name = "Log",
		},
		pem = {
			patterns = { "^.*%.pem$" },
			icon = "󰌆",
			color = colors.lemon,
			name = "Pemkey",
		},
		rc = {
			patterns = { "^%..*%rc$" },
			icon = "󱃲",
			color = colors.slate,
			name = "dotrc",
		},
		templ = {
			patterns = { "^.*%.templ$" },
			icon = "",
			color = colors.teal,
			name = "Templ",
		},
		yaml = {
			patterns = { "^.*%.yaml$", "^.*%.yml$" },
			icon = "",
			color = colors.lavender,
			name = "Yaml",
		},
	},
}

for _, priority_tier in pairs(custom_patterns) do
	for name, data in pairs(priority_tier) do
		local entry = {}
		entry[name] = {
			icon = data.icon,
			color = data.color,
			name = data.name,
		}
		devicons.set_icon(entry)
	end
end

local function get_custom_pattern(tier, name)
	for _, data in pairs(tier) do
		for _, pattern in pairs(data.patterns) do
			if name:find(pattern) then
				return data
			end
		end
	end
	return nil
end

local original_get_icon = devicons.get_icon

devicons.get_icon = function(name, ext, opts)
	local match = get_custom_pattern(custom_patterns.first_priority, name)
	if match then
		return match.icon, "DevIcon" .. match.name
	end
	match = get_custom_pattern(custom_patterns.second_priority, name)
	if match then
		return match.icon, "DevIcon" .. match.name
	end
	return original_get_icon(name, ext, opts)
end

devicons.setup({
	color_icons = true,
	default = true,
	strict = true,
	override = {},
	override_by_filename = {},
})
