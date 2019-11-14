local greed_stats = Hooks:ReturnCall("readGreedStatsHook")

local menu_title = "Greed Stats Summary"
local menu_message = json.encode(greed_stats)
local menu_options = {
	[1] = {
		text = "Close",
		is_cancel_button = true,
	}
}

local menu = QuickMenu:new(menu_title, menu_message, menu_options)
menu:Show()
