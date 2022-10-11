ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("xFidelite:getPoints", function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end
    MySQL.Async.fetchAll("SELECT fidelite FROM users WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.getIdentifier()
    }, function(result) for _,v in pairs(result) do cb(v.fidelite) end end)
end)

RegisterNetEvent("xFidelite:addPoints")
AddEventHandler("xFidelite:addPoints", function(point)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (not xPlayer) then return end
    point = tonumber(point) + xFidelite.Gain
    MySQL.Async.execute("UPDATE users SET fidelite = @fidelite WHERE identifier = @identifier", {
        ["@fidelite"] = point,
        ["@identifier"] = xPlayer.getIdentifier()
    }, function(result2)
        if result2 ~= nil then TriggerClientEvent('esx:showNotification', source, xFidelite.NotificationGain) end
    end)
end)

ESX.RegisterServerCallback("xFidelite:getGroup", function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end
    cb(xPlayer.getGroup())
end)

RegisterNetEvent("xFidelite:addPointsAdmin")
AddEventHandler("xFidelite:addPointsAdmin", function(id, count)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(id)

    if (not xPlayer) then return end
    if (not tPlayer) then TriggerClientEvent('esx:showNotification', source, '(~r~Erreur~s~)\nID invalide.') end
    MySQL.Async.fetchAll("SELECT fidelite FROM users WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.getIdentifier()
    }, function(result)
        for _,v in pairs(result) do 
            v.fidelite = v.fidelite + count
            MySQL.Async.execute("UPDATE users SET fidelite = @fidelite WHERE identifier = @identifier", {
                ["@fidelite"] = v.fidelite,
                ["@identifier"] = tPlayer.getIdentifier()
            }, function(result2)
                if result2 ~= nil then 
                    TriggerClientEvent('esx:showNotification', source, ('(~g~Succès~s~)\nVous avez donner ~g~x%s~s~ points à ~r~%s~s~'):format(count, tPlayer.getName()))
                    TriggerClientEvent('esx:showNotification', tPlayer.source, xFidelite.NotificationGivePoint)
                end
            end)
        end 
    end)
end)

--- Xed#1188 | https://discord.gg/HvfAsbgVpM