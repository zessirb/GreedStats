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



		{
			"hook_id": "lib/states/missionendstate",
			"script_path": "scripts/RegisterStats.lua"
		},
		{
			"hook_id": "lib/managers/experiencemanager",
			"script_path": "scripts/RegisterStats.lua"
		},
		{
			"hook_id": "lib/managers/moneymanager",
			"script_path": "scripts/RegisterStats.lua"
		},



local statistic_result_function = MissionEndState:on_statistics_result
function MissionEndState:on_statistics_result(best_kills_peer_id, best_kills_score, best_special_kills_peer_id, best_special_kills_score, best_accuracy_peer_id, best_accuracy_score, most_downs_peer_id, most_downs_score, total_kills, total_specials_kills, total_head_shots, group_accuracy, group_downs)
	log("on_statistics_result begin")
	log(toconsole(best_kills_scpre))
	statistic_result_function(best_kills_peer_id, best_kills_score, best_special_kills_peer_id, best_special_kills_score, best_accuracy_peer_id, best_accuracy_score, most_downs_peer_id, most_downs_score, total_kills, total_specials_kills, total_head_shots, group_accuracy, group_downs)
	log(toconsole(self._statistics_data))
	log("on_statistics_result end")
end

--  Inserting XP data
if RequiredScript == "lib/managers/experiencemanager" then
    Hooks:PostHook(ExperienceManager, "give_experience", "XpHook²²", function(self)
        log("get_xp_by_params begin")
--        local active_job = self.managers.job:has_active_job()
--        if not active_job then
--            log("No active job so no xp for you !")
--            return
--        end
--        local job_id = self.managers.job:current_job_id()
--        local total_xp = self._global.total
--        log(toconsole(total_xp))
--        log("get_xp_by_params end close")
--        Hooks:Call("insertXpDataHook", job_id, total_xp, heist_timer, difficulty, num_winners)
        log("get_xp_by_params end")
    end)
end

--  Inserting money data
if RequiredScript == "lib/managers/moneymanager" then
    Hooks:PostHook(MoneyManager, "get_payouts", "MoneyHook", function(self)
        log("get_money_by_params begin")
        local active_job = managers.job:has_active_job()
        if not active_job then
            log("No active job so no money for you !")
            return
        end
        log("so it's active")
        log(toconsole(managers.job))
        local job_id = managers.job:current_job_id()
        log(job_id)
		
		
        -- local total_money = self._global.total
        -- log(toconsole(total_money))
        -- local difficulty = active_job and managers.job:current_difficulty_stars() or 0
        -- local heist_timer = managers.game_play_central.get_heist_timer()
        -- log(toconsole(heist_timer))
        -- log("get_money_by_params end close")
        -- Hooks:Call("insertMoneyDataHook", job_id, total_money, heist_timer, difficulty, 1)
        -- log("get_money_by_params end")
        log("get_money_by_params end")
    end)
end