-- ESX SYSTEM
if Config.esx then
ESX = exports["es_extended"]:getSharedObject()
else
ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end
-- ESX SYSTEM

CreateThread(function()
	--SetConvarServerInfo("SC-CMD", "V1")
print("^4[^3SC^4] ^2Made By SnepCnep ^7")

Citizen.Wait(5000)
        print("^4[^3SC^4]^2-----------------------------------------------^7")
if Config.esx then
        print("^4[^3SC^4] ^7SC-Addons loaded on ESX version (1.8.5+)")
else 
        print("^4[^3SC^4] ^7SC-Addons loaded on ESX version (1.2+)")
            end
        print("^4[^3SC^4]^2-----------------------------------------------^7")
end)

