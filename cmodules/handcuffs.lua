if Config.handcuffs then

-- ESX SYSTEM
if Config.esx then
ESX = exports["es_extended"]:getSharedObject()
else
ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end
-- ESX SYSTEM


local cuffed = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if cuffed == true then
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)

			SetEntityMaxSpeed(playerPed, 4.0)

			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			SetEntityMaxSpeed(playerPed, 10.0)
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent(Tconfig.cuffplayer)
AddEventHandler(Tconfig.cuffplayer, function(target)

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict('mp_arrest_paired')

	while not HasAnimDictLoaded('mp_arrest_paired') do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)

	Citizen.Wait(3000)

	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(100)
		RequestAnimDict('mp_arresting')
	end

	TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

	cuffed = true
end)

RegisterNetEvent(Tconfig.cuffingplayer)
AddEventHandler(Tconfig.cuffingplayer, function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict('mp_arrest_paired')

	while not HasAnimDictLoaded('mp_arrest_paired') do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	ClearPedSecondaryTask(playerPed)
end)

RegisterNetEvent(Tconfig.uncuffplayer)
AddEventHandler(Tconfig.uncuffplayer, function(target)
	cuffed = false

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict('mp_arresting')

	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, 'mp_arresting', 'b_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(5500)
	DetachEntity(GetPlayerPed(-1), true, false)

	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent(Tconfig.uncuffingplayer)
AddEventHandler(Tconfig.uncuffingplayer, function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict('mp_arresting')

	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(5500)

	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent(Tconfig.closestplayercuff)
AddEventHandler(Tconfig.closestplayercuff, function(type)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()

	if distance < 0.9 then
		TriggerServerEvent(Tconfig.cuff, GetPlayerServerId(closestPlayer), type)
	else
		ESX.ShowNotification('Er is niemand om te handboeien')
	end
end)

RegisterNetEvent(Tconfig.closestplayeruncuff)
AddEventHandler(Tconfig.closestplayeruncuff, function(type)
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()

	if distance < 0.9 then
		TriggerServerEvent(Tconfig.uncuff, GetPlayerServerId(closestPlayer), type)
	else
		ESX.ShowNotification('Er is niemand om te handboeien')
	end
end)

RegisterNetEvent(Tconfig.Drag)
AddEventHandler(Tconfig.Drag, function()
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()

	if distance < 0.9 then
		TriggerServerEvent(Tconfig.drag, GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification('Er is niemand om te draggen')
	end
end)

function LoadDict(animDict)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end
end

local pushingAnimDict = "switch@trevor@escorted_out"
local pushingAnim = "001215_02_trvs_12_escorted_out_idle_guard2"
local running = false

local dragging = false

RegisterNetEvent(dragpolice)
AddEventHandler(dragpolice, function(target)

	dragging = not dragging

	if running then
        return
    end

	running = true

	Citizen.CreateThread(function()
        while dragging == true do
            Citizen.Wait(0)
            DisableControlAction(2, 21, true)
            local playerPed = PlayerPedId()
            local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
            if IsEntityAttachedToEntity(targetPed, playerPed) == false then
                Citizen.Wait(1000)
                if IsEntityAttachedToEntity(targetPed, playerPed) == false then
                  dragging = false
                end
            end
            local isWalking = IsPedWalking(playerPed)
            local isPlayingAnim = IsEntityPlayingAnim(playerPed, pushingAnimDict, pushingAnim, 3)
            if isWalking and not isPlayingAnim then
                LoadDict(pushingAnimDict)
                TaskPlayAnim(playerPed, pushingAnimDict, pushingAnim, 2.0, 2.0, -1, 51, 0, false, false, false)
            elseif not isWalking and isPlayingAnim then
                StopAnimTask(playerPed, pushingAnimDict, pushingAnim, -4.0)
            end
        end
        running = false
    end)
end)

local walkingAnimDict = "anim@move_m@grooving@"
local walkingAnim = "walk"

local IsDragged = false
local detached = true

RegisterNetEvent(Tconfig.dragcriminal)
AddEventHandler(Tconfig.dragcriminal, function(officer)

	IsDragged = not IsDragged

	while IsDragged == true do
		Wait(0)

		detached = false

		local ped = GetPlayerPed(GetPlayerFromServerId(officer))
		local myped = GetPlayerPed(-1)

		if not IsPedSittingInAnyVehicle(ped) then
		  	AttachEntityToEntity(myped, ped, 11816, 0.0, 0.64, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
		  	IsDragged = false
		end
	
		if IsPedDeadOrDying(ped, true) then
		  	IsDragged = false
		end
	
		local isPlayingAnim = IsEntityPlayingAnim(myped, walkingAnimDict, walkingAnim, 3)
		local isCopWalking = IsPedWalking(ped)
	
		if not HasAnimDictLoaded(walkingAnimDict) then
			LoadDict(walkingAnimDict)
		end
	
		if isCopWalking ~= false and isPlayingAnim == false then
		  	TaskPlayAnim(myped, walkingAnimDict, walkingAnim, 2.0, 2.0, -1, 1, 0, false, false, false)
		elseif isCopWalking == false and isPlayingAnim ~= false then
		  	StopAnimTask(myped, walkingAnimDict, walkingAnim, -4.0)
		end
	end
	if detached == false then
		detached = true
		DetachEntity(GetPlayerPed(-1), true, false)
	end
end)

end