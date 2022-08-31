local ESX = nil;

TriggerEvent("esx:getSharedObject", function(obj)
	ESX = obj;
end);

Citizen.CreateThread(function()
	while true do 
		local coords = GetEntityCoords(PlayerPedId());
		
		for index,ring in pairs(Config.Rings) do
			local dist = GetDistanceBetweenCoords(coords, ring.pos[1], ring.pos[2], ring.pos[3], true);
			
			if dist < 30 and ring.marker then
				DrawMarker(ring.marker, ring.pos[1], ring.pos[2], ring.pos[3], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 128, 0, 50, false, true, 2, nil, nil, false);
			end
			
			if dist < ring.radius then
				ESX.ShowHelpNotification(_U("open_menu_hint"));
				
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("ngRing:Ring", index);
				end
			end
		end

		Citizen.Wait(0)
	end
end);
