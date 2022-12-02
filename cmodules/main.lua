
----- Begin #antivdm
if Config.antivdm then

Citizen.CreateThread(function()
    while true do
        SetWeaponDamageModifier(-1553120962, 0.0)
        Wait(0)
    end
end)
    
end

---- Begin #nodriveby
if Config.nodriveby then

local passengerDriveBy = true
Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
	end
end)

end

---- Begin #Discord
if Config.discord then

Citizen.CreateThread(function()
    while true do
		local id = GetPlayerServerId(PlayerId())
		local name = GetPlayerName(PlayerId())
		local playerCount = #GetActivePlayers()
        -- This is the Application ID (Replace this with you own)
        SetDiscordAppId(Config.id)
		SetRichPresence(playerCount.."/128 - ID: "..id.." | Name: "..name)
	SetDiscordAppId(Config.id)
	SetDiscordRichPresenceAsset(Config.blogoname)
        SetDiscordRichPresenceAssetText(Config.btext)
        SetDiscordRichPresenceAssetSmall(Config.slogoname)
        SetDiscordRichPresenceAssetSmallText(Config.stext)
        SetDiscordRichPresenceAction(0, Config.buttonnaam1, Config.buttonlink1)
        SetDiscordRichPresenceAction(1, Config.buttonnaam2, Config.buttonlink2)
	Wait(60000)
    end
end)

end

---- Begin #pointfinger
if Config.pointfinger then

startPointing = function()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
	TaskMoveNetworkByName(ped, 'task_mp_pointing', 0.5, false, 'anim@mp_point', 24)
    RemoveAnimDict("anim@mp_point")
end

stopPointing = function()
    local ped = PlayerPedId()
	RequestTaskMoveNetworkStateTransition(ped, 'Stop')
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

RegisterCommand('point', function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        if mp_pointing then
            stopPointing()
            mp_pointing = false
        else
            startPointing()
            mp_pointing = true
        end
        while mp_pointing do
            local ped = PlayerPedId()
            local camPitch = GetGameplayCamRelativePitch()
            if camPitch < -70.0 then
                camPitch = -70.0
            elseif camPitch > 42.0 then
                camPitch = 42.0
            end
            camPitch = (camPitch + 70.0) / 112.0

            local camHeading = GetGameplayCamRelativeHeading()
            local cosCamHeading = Cos(camHeading)
            local sinCamHeading = Sin(camHeading)
            if camHeading < -180.0 then
                camHeading = -180.0
            elseif camHeading > 180.0 then
                camHeading = 180.0
            end
            camHeading = (camHeading + 180.0) / 360.0

            local blocked = 0
            local nn = 0

            local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
            local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
            nn,blocked,coords,coords = GetRaycastResult(ray)	
			SetTaskMoveNetworkSignalFloat(ped, "Pitch", camPitch)
			SetTaskMoveNetworkSignalFloat(ped, "Heading", camHeading * -1.0 + 1.0)
			SetTaskMoveNetworkSignalBool(ped, "isBlocked", blocked)
			SetTaskMoveNetworkSignalBool(ped, "isFirstPerson", GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
            Wait(1)
        end
    end
end)

RegisterKeyMapping('point', 'Toggles Point', 'keyboard', 'b')

end

---- Begin #handsup
if Config.handsup then

local animDict = "missminuteman_1ig_2"
local anim = "handsup_base"
local handsup = false

RegisterKeyMapping('hu', 'Doe je handen omhoog.', 'KEYBOARD', 'X')

RegisterCommand('hu', function()
    local ped = PlayerPedId()
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
    handsup = not handsup
    if handsup then
        TaskPlayAnim(ped, animDict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                CreateThread(function()
                    while handsup do
                        Wait(1)
                        DisableControlAction(0, 59, true) -- Disable steering in vehicle
			            DisableControlAction(0,21,true) -- disable sprint
                        DisableControlAction(0,24,true) -- disable attack
                        DisableControlAction(0,25,true) -- disable aim
                        DisableControlAction(0,47,true) -- disable weapon
                        DisableControlAction(0,58,true) -- disable weapon
                        DisableControlAction(0,71,true) -- veh forward
                        DisableControlAction(0,72,true) -- veh backwards
                        DisableControlAction(0,63,true) -- veh turn left
                        DisableControlAction(0,64,true) -- veh turn right
                        DisableControlAction(0,263,true) -- disable melee
                        DisableControlAction(0,264,true) -- disable melee
                        DisableControlAction(0,257,true) -- disable melee
                        DisableControlAction(0,140,true) -- disable melee
                        DisableControlAction(0,141,true) -- disable melee
                        DisableControlAction(0,142,true) -- disable melee
                        DisableControlAction(0,143,true) -- disable melee
                        DisableControlAction(0,75,true) -- disable exit vehicle
                        DisableControlAction(27,75,true) -- disable exit vehicle
                    end
                end)
            end
        end
    else
        ClearPedTasks(ped)
    end
end, false)

end