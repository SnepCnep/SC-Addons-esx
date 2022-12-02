-- ESX SYSTEM
if Config.esx then
ESX = exports["es_extended"]:getSharedObject()
else
ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- ESX SYSTEM
if Config.txaddons then

local frozenPlayers = {}

local function isPlayerFrozen(targetId)
  return frozenPlayers[targetId] or false
end
local function isPlayerunFrozen(targetId)
  return frozenPlayers[targetId] or true
end

RegisterCommand('sc-test', function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
			TriggerClientEvent('okokNotify:Alert', src, "SnepCnep Test", "success.", 10000, 'success')
			TriggerClientEvent('okokNotify:Alert', src, "SnepCnep Test", "info.", 10000, 'info')
			TriggerClientEvent('okokNotify:Alert', src, "SnepCnep Test", "error.", 10000, 'error')
			TriggerClientEvent('okokNotify:Alert', src, "SnepCnep Test", "warning.", 10000, 'warning')
			TriggerClientEvent('okokNotify:Alert', src, "SnepCnep Test", "phonemessage.", 10000, 'phonemessage')
			TriggerClientEvent('okokNotify:Alert', src, "SnepCnep Test", "neutral.", 10000, 'neutral')
end)

if Config.txtpm then
RegisterCommand(Config.tpmcmd, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if IsPlayerAceAllowed(source, "sc.tpm") then
            TriggerClientEvent('txAdmin:menu:tpToWaypoint', src)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U bent geteleport naar u waypoint.", 2000, 'success')
        else
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.tpm)", 2500, 'error')
    end
end)
end

if Config.txrepair then
RegisterCommand(Config.repaircmd, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if IsPlayerAceAllowed(source, "sc.repair") then
            TriggerClientEvent('txAdmin:menu:fixVehicle', src)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft uw auto gerepareerd.", 2000, 'success')
        else
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.repair)", 2500, 'error')
        end
end)
end

if Config.txfreeze then
RegisterCommand(Config.freezecmd, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local newFrozenStatus = not isPlayerFrozen(targetId)

    if IsPlayerAceAllowed(source, "sc.freeze") then
        if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        else
    TriggerClientEvent("txAdmin:menu:freezePlayer", args[1], newFrozenStatus)
        end
    end
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.freeze)", 2500, 'error')
end)

RegisterCommand(Config.unfreezecmd, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local newunFrozenStatus = not isPlayerunFrozen(targetId)

    if IsPlayerAceAllowed(source, "sc.freeze") then
        if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        else
    TriggerClientEvent("txAdmin:menu:freezePlayer", args[1], newunFrozenStatus)
        end
    end
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.freeze)", 2500, 'error')
end)
end

if Config.txmededeling then
RegisterCommand(Config.txmededeling, function(source, args, xPlayer)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if IsPlayerAceAllowed(source, "sc.mededeling") then
        TriggerClientEvent("txAdmin:receiveAnnounce", -1, table.concat(args, " "), xPlayer.source )
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '[sc] Je hebt geen permissions voor dit.', style = { ['background-color'] = '#FF0000', ['color'] = '#60E1FA' } })
    end
end)
end

if Config.txtpc then
RegisterCommand(Config.tpccmd, function(source, args, xPlayer)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
    if IsPlayerAceAllowed(source, "sc.tpc") then
 TriggerClientEvent('txAdmin:menu:tpToCoords', src, x, y, z)
    else
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.tpc)", 2500, 'error')
    end
end)
end

if Config.txtroll then
if Config.drunk then
RegisterCommand(Config.drunkcmd, function(source, args, xPlayer)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local id = tonumber(args[1])
    if IsPlayerAceAllowed(source, "sc.troll") then
        if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        TriggerClientEvent('txAdmin:menu:drunkEffect', id)
    else
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.troll)", 2500, 'error')
    end
end
end)
end

if Config.fire then
RegisterCommand(Config.firecmd, function(source, args, xPlayer)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local id = tonumber(args[1])
    if IsPlayerAceAllowed(source, "sc.troll") then
                                    if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        TriggerClientEvent('txAdmin:menu:setOnFire', id)
    else
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.troll)", 2500, 'error')
    end
end
end)
end

if Config.animal then
RegisterCommand(Config.animalcmd, function(source, args, xPlayer)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local id = tonumber(args[1])
    if IsPlayerAceAllowed(source, "sc.troll") then
        if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        TriggerClientEvent('txAdmin:menu:wildAttack', id)
    else
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft geen rechten voor dit! \n (perms: sc.troll)", 2500, 'error')
    end
end
end)

end
end

if Config.txchatkbw then
AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    local admin = eventData.author
    local reason = eventData.reason

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(65,65,65, 0.6); border-radius: 3px;"><span style="color: red;">[Staff]:</span> Er is <span style="color: yellow;"></span> iemand op vakantie gestuurd door <span style="color: green;">{0}</span> voor <span style="color: yellow;">{1}</span></div>',
        args = { admin, reason }
    })

end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    local id = eventData.target
    local admin = eventData.author
    local reason = eventData.reason

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(65,65,65, 0.6); border-radius: 3px;"><span style="color: red;">[Staff]:</span> Speler met ID <span style="color: yellow;">[{0}]</span> heeft een warn gekregen door <span style="color: green;">{1}</span> voor <span style="color: yellow;">{2}</span></div>',
        args = { id, admin, reason }
    })
end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    local id = eventData.target
    local admin = eventData.author
    local reason = eventData.reason

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(65,65,65, 0.6); border-radius: 3px;"><span style="color: red;">[Staff]:</span> Speler met ID <span style="color: yellow;">[{0}]</span> is gekicked door <span style="color: green;">{1}</span> voor <span style="color: yellow;">{2}</span></div>',
        args = { id, admin, reason }
    })

end)
end
end