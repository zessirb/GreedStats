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

function clone_function(fn)
    local dumped = string.dump(fn)
    local cloned = loadstring(dumped)
    local i = 1
    while true do
        local name = debug.getupvalue(fn, i)
        if not name then
            break
        end
        debug.upvaluejoin(cloned, i, fn, i)
        i = i + 1
    end
    return cloned
end



--  Inserting XP data
if RequiredScript == "lib/managers/experiencemanager" then
    Hooks:PostHook(ExperienceManager, "get_xp_by_params", "DO IT XP", function(self, params)
        log("get_xp_by_params begin")
        local get_xp_by_params_clone = clone_function(self.get_money_by_params)
        local total_xp = get_xp_by_params_clone(params)
        local job_id = params.job_id
        local heist_timer = self.managers.game_play_central.get_heist_timer()
        local difficulty = params.difficulty_stars or params.risk_stars or 0
        local num_winners = params.num_winner or 1
        log(total_xp)
        log(toconsole(total_xp))
        log("get_xp_by_params end close")
        Hooks:Call("insertXpDataHook", job_id, total_xp, heist_timer, difficulty, num_winners)
        log("get_xp_by_params end")
    end)
end

--  Inserting money data
if RequiredScript == "lib/managers/moneymanager" then
    Hooks:PostHook(MoneyManager, "get_payouts", "DO IT MONEY", function(self)
--        log("get_money_by_params begin")
--        local active_job = self.managers.job:has_active_job()
--        local difficulty = active_job and self.managers.job:current_difficulty_stars() or 0
--        local total_money = get_money_by_params_clone(params).total_payout
--        log(toconsole(total_money))
--        local job_id = self.managers.job:current_job_id()
--        local heist_timer = self.managers.game_play_central.get_heist_timer()
--        local num_winners = params.num_winner or 1
--        log(total_money)
--        log(toconsole(total_money))
--        log("get_money_by_params end close")
--        Hooks:Call("insertMoneyDataHook", job_id, total_money, heist_timer, difficulty, num_winners)
--        log("get_money_by_params end")
    end)
end