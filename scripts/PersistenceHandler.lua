_G.PersistenceHandler = _G.PersistenceHandler or {}

function PersistenceHandler:init(profile_name)
    log("persistence init begin")
    self._profile_name = profile_name
    local file = io.open("greed_stats_" .. self._profile_name .. ".txt", "r")
    if file ~= nil then
        log("[greed_stats] Greed file exists and doesn't need instantiation")
        file:close()
    else
        local file = io.open("greed_stats_" .. self._profile_name .. ".txt", "w")
        io.output(file)
        file:write("{}")
        file:close()
        log("[greed_stats] Instantiating Greed data file")
    end
end

--  Insert any kind of stats
function PersistenceHandler:insertGreedStatsData(job_id, dataTable)
    log("[greed_stats] Inserting " .. json.encode(dataTable))
    --    Reading data file
    local file = io.open("greed_stats_" .. self._profile_name .. ".txt", "r+")
    local file_content = file:read("*a")
    local data = json.decode(file_content)
    file:close()
    --    Initializing current job dicts
    local current_time = "%m/%d/%Y %H-%M"
    if data[job_id] == nil then
        data[job_id] = {}
    end
    if data[job_id][current_time] == nil then
        data[job_id][current_time] = {}
    end
    --    Inserting new values into dict
    for k, v in pairs(dataTable) do
        data[job_id][current_time][k] = v
    end
    --    Inserting into file and closing
    local file = io.open("greed_stats_" .. self._profile_name .. ".txt", "w")
    file:write(json.encode(data))
    file:close()
    log("insert end")
end

--  Fetch stats in file
function PersistenceHandler:readGreedStats()
    log("readGreed begin")
    log("we will open greed_stats_" .. self._profile_name .. ".txt")
    local file = io.open("greed_stats_" .. self._profile_name .. ".txt", "r+")
    local data = file:read("*a")
    file:close()
    log("[greed_stats] " .. data)
    log("readGreed end")
    return data
end

--  Add stats
--Hooks:RegisterHook("insertStatsHook")
--Hooks:AddHook("insertStatsHook", "insertStats", function (job_id, money_amount, xp_amount, heist_timer, crew_size)
--    log("insertStatsHook begin")
--    PersistenceHandler:insertGreedStatsData(job_id, { money=money_amount, xp=xp_amount, time=heist_timer, team=crew_size })
--    log("insertStatsHook end")
--end)

----  Add money data
--Hooks:RegisterHook("insertMoneyDataHook")
--Hooks:AddHook("insertMoneyDataHook", "insertMoneyData", function (job_id, money, heist_timer, difficulty, num_winners)
--    log("insertMoneyDataHook begin")
--    insertGreedStatsData(job_id, { total_cash=money, timer=heist_timer, difficulty=difficulty, team_size=num_winners })
--    log("insertMoneyDataHook end")
--end)
--
----  Add XP data
--Hooks:RegisterHook("insertXpDataHook")
--Hooks:AddHook("insertXpDataHook", "insertXpData", function (job_id, xp, heist_timer, difficulty, num_winners)
--    log("insertXpDataHook begin")
--    insertGreedStatsData(job_id, { total_xp=xp, timer=heist_timer, difficulty=difficulty, team_size=num_winners })
--    log("insertXpDataHook end")
--end)
