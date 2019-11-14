--  Instantiating data files
if RequiredScript == "lib/states/bootupstate" then
    Hooks:PostHook(BootupState, "init", "BootupStateInitHook", function()
        local file = io.open("greed_stats_persistence.txt", "r")
        if file ~= nil then
            log("[greed_stats] Greed file exists and doesn't need instantiation")
            file:close()
            return
        end
        local file = io.open("greed_stats_persistence.txt", "w")
        io.output(file)
        file:write("{}")
        file:close()
        log("[greed_stats] Instantiating Greed data file")
    end)
end

Hooks:RegisterHook("readGreedStatsHook")
Hooks:AddHook("readGreedStatsHook", "readGreedStats", function ()
    local file = io.open("greed_stats_persistence.txt", "r+")
    local data = file:read("*a")
    file:close()
    log("[greed_stats] " .. data)
    return data
end)

local function insertGreedStatsData(job_id, dataTable)
    log("[greed_stats] Inserting " .. json.encode(dataTable))
    --    Reading data file
    local file = io.open("greed_stats_persistence.txt", "r+")
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
    local file = io.open("greed_stats_persistence.txt", "w")
    file:write(json.encode(data))
    file:close()
end

Hooks:RegisterHook("insertMoneyDataHook")
Hooks:AddHook("insertMoneyDataHook", "insertMoneyData", function (job_id, money, heist_timer, difficulty, num_winners)
    insertGreedStatsData(job_id, { total_cash=money, timer=heist_timer, difficulty=difficulty, team_size=num_winners })
end)

Hooks:RegisterHook("insertXpDataHook")
Hooks:AddHook("insertXpDataHook", "insertXpData", function (job_id, xp, heist_timer, difficulty, num_winners)
    insertGreedStatsData(job_id, { total_xp=xp, timer=heist_timer, difficulty=difficulty, team_size=num_winners })
end)
Hooks:RegisterHook("insertXpData")
