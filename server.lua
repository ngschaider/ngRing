local ESX = nil;

TriggerEvent("esx:getSharedObject", function(obj)
	ESX = obj;
end);

local getTargetPlayers = function(ring)
	local ret = {};
	
	for k,playerId in pairs(ESX.GetPlayers()) do
		local xPlayer = ESX.GetPlayerFromId(playerId);
		
		local passedJobCheck = false;
		local passedGroupCheck = false;
		
		if ring.jobs then 
			for k,v in pairs(ring.jobs) do
				if xPlayer.job.name == v.name then
					if xPlayer.job.grade >= v.grade then
						passedJobCheck = true;
					end
				end
			end
		else
			passedJobCheck = true;
		end
		
		if ring.groups then
			for k,group in pairs(ring.groups) do
				print(playerId, group);
				if IsPlayerAceAllowed(playerId, "group." .. group) or xPlayer.getGroup() == group then
					passedGroupCheck = true;
				end
			end
		else
			passedGroupCheck = true;
		end
		
		if passedJobCheck and passedGroupCheck then
			table.insert(ret, xPlayer);
		end
	end
	
	return ret;
end;

RegisterNetEvent("ngRing:Ring", function(index)
	local ring = Config.Rings[index];
	
	if not ring then
		return
	end
	
	for k,xPlayer in pairs(getTargetPlayers(ring)) do
		xPlayer.showNotification(ring.message);
	end
	
	
	local myPlayer = ESX.GetPlayerFromId(source);
	
	if ring.webhook then
	  local embed = {
			{
				["color"] = 16753920,
				["title"] = "**".. myPlayer.getName() .." (" .. GetPlayerName(source) .. ") hat geklingelt**",
				--["description"] = message,
				["footer"] = {
					["text"] = "ngRing",
				},
			}
		}

		PerformHttpRequest(ring.webhook, function(err, text, headers) end, 'POST', json.encode({
			username = "ngRing", 
			embeds = embed,
		}), {
			['Content-Type'] = 'application/json' 
		});
	end
	
	myPlayer.showNotification(_U("ring_success"));
end);