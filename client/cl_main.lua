ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
    while true do
        ESX.TriggerServerCallback("xFidelite:getPoints", function(result) 
            if result ~= nil then
                TriggerServerEvent("xFidelite:addPoints", result)
            end
        end)
        Wait(xFidelite.TimeForAddPoint * 60000)
    end
end)

TriggerEvent('chat:addSuggestion', "/givepoints", "/givepoints [id], [quantité]", nil)
RegisterCommand("givepoints", function(source, args, rawCommand)
    ESX.TriggerServerCallback("xFidelite:getGroup", function(group) 
        for _,v in pairs(xFidelite.RankAcces) do
            if v == group then
                local id, count = args[1], args[2]
                if id ~= nil and id ~= "" and count ~= nil and count ~= "" then
                    TriggerServerEvent("xFidelite:addPointsAdmin", id, tonumber(count))
                end
            end
        end
    end)
end)

--- Xed#1188 | https://discord.gg/HvfAsbgVpM