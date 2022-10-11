ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local open = false
local mainMenu = RageUI.CreateMenu("Boutique", "Acheter des choses avec vos points.", nil, nil, "root_cause5", xFidelite.Banniere)
mainMenu.Display.Header = true
mainMenu.Closed = function()
    open = false
end

local function MenuFidelite(point)
    if open then
        open = false
        RageUI.Visible(mainMenu, false)
    else
        open = true
        RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do
                Wait(0)
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Separator(("Vos points: ~r~%s"):format(point))
                    RageUI.Line()
                    for _,v in pairs(xFidelite.Boutique.Item) do
                        RageUI.Button(("~%s~→~s~ %s"):format(xFidelite.CouleurMenu, v.Label), nil, {RightLabel = ("~g~%s points~s~"):format(v.Price)}, true, {
                            onSelected = function()
                                TriggerServerEvent("xFidelite:buyItem", v.Name, v.Label, v.Price, point)
                                RageUI.CloseAll()
                                open = false
                            end
                        })
                    end
                    for _,v in pairs(xFidelite.Boutique.Car) do
                        RageUI.Button(("~%s~→~s~ %s"):format(xFidelite.CouleurMenu, v.Label), nil, {RightLabel = ("~g~%s points~s~"):format(v.Price)}, true, {
                            onSelected = function()
                                local model = GetHashKey(v.Model)
                                RequestModel(model)
                                while not HasModelLoaded(model) do Wait(10) end
                                local vehicle = CreateVehicle(model, GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()), true, false)
                                SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                TriggerServerEvent("xFidelite:buyCar", vehicleProps, v.Price, point)
                                RageUI.CloseAll()
                                open = false
                            end
                        })
                    end
                end)
            end
        end)
    end
end

RegisterCommand(xFidelite.CommandForOpenMenu, function()
    ESX.TriggerServerCallback("xFidelite:getPoints", function(result) 
        MenuFidelite(result)
    end)
end)

--- Xed#1188 | https://discord.gg/HvfAsbgVpM