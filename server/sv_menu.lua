ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("xFidelite:buyItem")
AddEventHandler("xFidelite:buyItem", function(item, label, price, point)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end
    if (point - price) >= 0 then
        point = point - price
        xPlayer.addInventoryItem(item, 1)
        MySQL.Async.execute("UPDATE users SET fidelite = @fidelite WHERE identifier = @identifier", {
            ["@fidelite"] = point,
            ["@identifier"] = xPlayer.getIdentifier()
        }, function(result) if result ~= nil then TriggerClientEvent('esx:showNotification', source, ('(~g~Succès~s~)\nVous avez acheté ~r~un(e) %s~s~ pour ~r~%s points~s~.'):format(label, price)) end end)
    else
        TriggerClientEvent('esx:showNotification', source, ('(~r~Erreur~s~)\nIl vous manque ~r~%s points~s~.'):format(price - point))
    end
end)

ESX.RegisterServerCallback("xFidelite:buyCar", function(source, cb, vehicleProps, price, point)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end
    if (point - price) >= 0 then
        point = point - price
        MySQL.Async.execute("UPDATE users SET fidelite = @fidelite WHERE identifier = @identifier", {
            ["@fidelite"] = point,
            ["@identifier"] = xPlayer.getIdentifier()
        }, function(result) if result ~= nil then TriggerClientEvent('esx:showNotification', source, ('(~g~Succès~s~)\nVous avez acheté une voiture pour ~r~%s points~s~.'):format(price)) end end)
        cb(true)
    else
        TriggerClientEvent('esx:showNotification', source, ('(~r~Erreur~s~)\nIl vous manque ~r~%s points~s~.'):format(price - point))
        cb(false)
    end
end)

RegisterNetEvent("xFidelite:addCar")
AddEventHandler("xFidelite:addCar", function(vehicleProps)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.getIdentifier(),
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
        if rowsChange ~= nil then TriggerClientEvent('esx:showNotification', source, "(~g~Succès~s~)\nTu as reçu ton nouveau véhicule.") end
    end)
end)

--- Xed#1188 | https://discord.gg/HvfAsbgVpM
