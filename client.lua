ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
    
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local vehicleClass = GetVehicleClass(vehicle)
        local seat = GetPedInVehicleSeat(vehicle, -1)

        if vehicleClass == 18 then
            if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mecano' then
                -- You can add a check here if you want for admins to not kick them out of the vehicle. (Placed a little example here)
                -- ESX.TriggerServerCallback("staff-ui:fetchUserRank", function(playerRank)
                --     if playerRank == 'user' then
                        if seat == ped then
                            ESX.ShowNotification("~r~You're not allowed to drive in this vehicle!")
                            TaskLeaveVehicle(ped, vehicle, 0)
                        end
                --     end
                -- end)
            end
        end
    
    end
end)