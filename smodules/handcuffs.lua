if Config.handcuffs then

-- ESX SYSTEM
if Config.esx then
ESX = exports["es_extended"]:getSharedObject()
else
ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end
-- ESX SYSTEM


local cuffedPlayers = {}

RegisterServerEvent(Tconfig.cuff)
AddEventHandler(Tconfig.cuff, function(target, type)
    if target ~= -1 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)

        if cuffedPlayers[tostring(xTarget.source)] == nil then

            if type == 'police' then
                if xPlayer.getInventoryItem(Config.itemhandboeien).count > 0 then
                    xPlayer.removeInventoryItem(Config.itemhandboeien, 1)
                    TriggerClientEvent(Tconfig.cuffingplayer, xPlayer.source)
                    TriggerClientEvent(Tconfig.cuffplayer, xTarget.source, xPlayer.source)
                    cuffedPlayers[tostring(xTarget.source)] = 'police'
                else
                    xPlayer.showNotification("Je hebt geen handboeien om te gebruiken")
                end
            elseif type == 'gangster' then
                if xPlayer.getInventoryItem(Config.itemtiewrap).count > 0 then
                    xPlayer.removeInventoryItem(Config.itemtiewrap, 1)
                    TriggerClientEvent(Tconfig.cuffingplayer, xPlayer.source)
                    TriggerClientEvent(Tconfig.cuffplayer, xTarget.source, xPlayer.source)
                    cuffedPlayers[tostring(xTarget.source)] = 'gangster'
                else
                    xPlayer.showNotification("Je hebt geen tie wraps om te gebruiken")
                end
            end
        else
            xPlayer.showNotification("Deze persoon heeft al handboeien om")
        end
    else
        print('HACKER ' .. source)
    end
end)

RegisterServerEvent(Tconfig.uncuff)
AddEventHandler(Tconfig.uncuff, function(target, type)
    if target ~= -1 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)

        if type == 'police' then
            if cuffedPlayers[tostring(xTarget.source)] ~= nil then
                if cuffedPlayers[tostring(xTarget.source)] == 'police' then
                    xPlayer.addInventoryItem(Config.itemhandboeien, 1)
                    TriggerClientEvent(Tconfig.uncuffingplayer, xPlayer.source)
                    TriggerClientEvent(Tconfig.uncuffplayer, xTarget.source, xPlayer.source)
                    cuffedPlayers[tostring(xTarget.source)] = nil
                else
                    xPlayer.showNotification("Deze persoon is vastgemaakt met tie wraps, je zal deze moeten losknippen")
                end
            else
                xPlayer.showNotification("Deze persoon heeft geen handboeien aan")
            end
        elseif type == 'gangster' then
            if cuffedPlayers[tostring(xTarget.source)] ~= nil then
                if cuffedPlayers[tostring(xTarget.source)] == 'gangster' then
                    if xPlayer.getInventoryItem(Config.itemcutters).count > 0 then
                        TriggerClientEvent(Tconfig.uncuffingplayer, xPlayer.source)
                        TriggerClientEvent(Tconfig.uncuffplayer, xTarget.source, xPlayer.source)
                        cuffedPlayers[tostring(xTarget.source)] = nil
                    else
                        xPlayer.showNotification("Je hebt geen kniptang om te gebruiken")
                    end
                elseif cuffedPlayers[tostring(xTarget.source)] == 'police' then
                    if xPlayer.getInventoryItem(Config.itembigcutters).count > 0 then
                        TriggerClientEvent(Tconfig.uncuffingplayer, xPlayer.source)
                        TriggerClientEvent(Tconfig.uncuffplayer, xTarget.source, xPlayer.source)
                        cuffedPlayers[tostring(xTarget.source)] = nil
                    else
                        xPlayer.showNotification("Je hebt geen heggen schaar om te gebruiken")
                    end
                end
            else
                xPlayer.showNotification("Deze persoon heeft geen handboeien aan")
            end
        end
    else
        print('HACKER ' .. source)
    end
end)

RegisterServerEvent(Tconfig.drag)
AddEventHandler(Tconfig.drag, function(target)
    if target ~= -1 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)

        if cuffedPlayers[tostring(xTarget.source)] ~= nil then
            TriggerClientEvent(dragpolice, xPlayer.source, xTarget.source)
            TriggerClientEvent(Tconfig.dragcriminal, xTarget.source, xPlayer.source)            
        else
            xPlayer.showNotification("Deze persoon heeft geen handboeien om")
        end
    else
        print('HACKER ' .. source)
    end
end)


ESX.RegisterUsableItem(Config.itemtiewrap, function(source)
    TriggerClientEvent(Tconfig.closestplayercuff, source, 'gangster')
end)

ESX.RegisterUsableItem(Config.itemcutters, function(source)
    TriggerClientEvent(Tconfig.closestplayeruncuff, source, 'gangster')
end)

ESX.RegisterUsableItem(Config.itembigcutters, function(source)
    TriggerClientEvent(Tconfig.closestplayeruncuff, source, 'gangster')
end)

end