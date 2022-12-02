-- ESX SYSTEM
if Config.esx then
ESX = exports["es_extended"]:getSharedObject()
else
ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- ESX SYSTEM
if Config.sc_commands then
-- staffskin
if Config.skinmenu then
RegisterCommand(Config.skinmenucmd, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if IsPlayerAceAllowed(source, "sc.staffskin") then
        if args[1] == nil then
            TriggerClientEvent('esx_skin:openSaveableMenu', src)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft u zelf in staffskin gezet.", 2000, 'success')
        else
            TriggerClientEvent('esx_skin:openSaveableMenu', args[1])
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft iemand in staffskin gezet.", 2000, 'success')
        end
    end
end)
end -- end staffskin config

if Config.status then 
RegisterCommand(Config.food, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if IsPlayerAceAllowed(source, "sc.status") then
        if args[1] == nil then
            TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft u zelf eten gegeven.", 2000, 'success')
        else
            TriggerClientEvent('esx_status:add', args[1], 'hunger', 250000)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft iemand eten gegeven.", 2000, 'success')
        end
    end
end)
RegisterCommand(Config.drinks, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if IsPlayerAceAllowed(source, "sc.status") then
        if args[1] == nil then
            TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft u zelf drinken gegeven.", 2000, 'success')
        else
            TriggerClientEvent('esx_status:add', args[1], 'thirst', 250000)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft iemand drinken gegeven.", 2000, 'success')
        end
    end
end)

end



end -- Config.sc-commands