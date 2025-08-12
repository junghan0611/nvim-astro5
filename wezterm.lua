local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 스크립트 실행해서 폰트 크기 가져오기
local function get_font_size()
	local handle = io.popen(
		"~/.local/bin/set-font-size.sh 2>/dev/null | grep '터미널 폰트:' | sed 's/.*터미널 폰트: //'"
	)
	local result = handle:read("*a")
	handle:close()
	local font_size = tonumber(result:match("([%d%.]+)")) or 17.0
	wezterm.log_info("스크립트에서 받은 폰트 크기: " .. font_size)
	return font_size
end

local font_size = get_font_size()

config.window_background_opacity = 0.8
config.text_background_opacity = 0.8
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("Sarasa Term K Nerd Font", { weight = "Regular", italic = false })
config.font_size = font_size
config.initial_cols = 150
config.initial_rows = 35

config.color_scheme = "Dracula (Official)"
-- color_scheme = 'Sweet Eliverlara (Gogh)',
config.audible_bell = "Disabled"

return config
