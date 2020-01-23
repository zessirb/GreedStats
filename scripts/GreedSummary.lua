-- Console logging utility (used to dump dicts)
function toconsole(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..tostring(k)..'"' end
			s = s .. '['..k..'] = ' .. toconsole(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

log("GreedSummary begin")
        
--  Fetching Greed Stats data
local persistence_handler = PersistenceHandler:new("default")
local greed_data = persistence_handler:readGreedStats()
log(toconsole(greed_data))
local greed_stats = json.decode(greed_data)

--  Initializing menus variables
_G.GreedStatsMenus = _G.GreedStatsMenus or {}
GreedStatsMenus._path = ModPath
GreedStatsMenus._data_path = SavePath.."greedstats_config.txt"
GreedStatsMenus._prefix_path = SavePath.."greedstats_prefix_data.txt"
GreedStatsMenus._prefix = {}
GreedStatsMenus._data = {}

function GreedStatsMenus:Save()
	local file = io.open( self._data_path, "w+")
	if file then
		file:write(json.encode(self._data))
		file:close()
	end
end

function GreedStatsMenus:Load()
	local GreedStatsMenus = io.open(self._data_path, "r")
	if file then
		self._data = json.decode(file:read("*all"))
		file:close()
	else 
		self:Create(1)
	end
	
	local prefix_file = io.open(self._prefix_path,"r")
	if prefix_file then
		self._prefix = json.decode(prefix_file:read("*all"))
		prefix_file:close()
	else
		self:Create(2)
	end
end

Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_GreedStatsMenu", function(menu_manager)
    log("MenuManagerInitialize begin")
        
	GreedStatsJsonMenus = {"../menus/SummaryHome.json"}
	GreedStatsMenus:Load()
	for _,v in ipairs(GreedStatsJsonMenus) do 
		MenuHelper:LoadFromJsonFile(GreedStatsMenus._path .. v, GreedStatsMenus, GreedStatsMenus._data)
	end
    log("MenuManagerInitialize end")
end )
