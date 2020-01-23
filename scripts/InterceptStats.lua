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

CloneClass(MissionEndState)

function MissionEndState:new(...)
    log("end init begin")
    self.orig.new(self, ...)
    self._persistence_handler = PersistenceHandler:new("default")
    log("end init end")
end

function MissionEndState:on_statistics_result(...)
    log("on_statistics_result begin")
	self.orig.on_statistics_result(self, ...)
	if managers.network and managers.network:session() and managers.job:on_last_stage() then
		-- Fetching data
		local crew_size = managers.network:session():amount_of_players()
		local heist_time = managers.statistics:get_session_time_seconds()
		local job_contact = managers.job:current_contact_id()
		local job_name = managers.job:current_job_id()
        local job_id = job_contact .. ":" .. job_name
		local offshore_amount = managers.experience:cash_string(managers.money:heist_offshore())
		local cash_amount = managers.experience:cash_string(managers.money:heist_spending())
        local money_amount = offshore_amount + cash_amount
        local xp_amount = managers.experience:get_xp_dissected(true, crew_size, true)
		-- Data export
		log(toconsole("[greed_stats] Preparing to save " .. job_id .. " heist reward: " .. money_amount .. " money ; " .. xp_amount .. " xp ; " .. heist_time .. " seconds"))
        self._persistence_handler:insertGreedStatsData(job_id, { money=money_amount, xp=xp_amount, time=heist_time, team=crew_size })
	end
    log("on_statistics_result end")
end
