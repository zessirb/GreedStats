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



--  Inserting XP data
if RequiredScript == "lib/managers/experiencemanager" then
    Hooks:PostHook(ExperienceManager, "get_xp_by_params", "DO IT XP", function(self, params)
        local total_xp = self.get_xp_by_params(params)
        local job_id = params.job_id
        local heist_timer = self.managers.game_play_central.get_heist_timer()
        local difficulty = params.difficulty_stars or params.risk_stars or 0
        local num_winners = params.num_winner or 1
        log(total_xp)
        log(toconsole(total_xp))
        Hooks:Call("insertXpDataHook", job_id, total_xp, heist_timer, difficulty, num_winners)
    end)
end

--  Inserting money data
if RequiredScript == "lib/managers/moneymanager" then
    Hooks:PostHook(MoneyManager, "get_money_by_params", "DO IT MONEY", function(self, params)
        local total_money = self.get_money_by_params(params).total_payout
        local job_id = params.job_id
        local heist_timer = self.managers.game_play_central.get_heist_timer()
        local difficulty = params.difficulty_stars or params.risk_stars or 0
        local num_winners = params.num_winner or 1
        log(total_money)
        log(toconsole(total_money))
        Hooks:Call("insertMoneyDataHook", job_id, total_money, heist_timer, difficulty, num_winners)
    end)
end