
Citizen.CreateThread(function() 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
    
    while ESX == nil do Wait(0) end
    while not ESX.IsPlayerLoaded() do Wait(5) end 

    local open = false 
    local Mainmenu = RageUI.CreateMenu("LTD","By 25") 
    local boisson = RageUI.CreateSubMenu(Mainmenu,"Boisson","Menu")
    local nourriture = RageUI.CreateSubMenu(Mainmenu,"Nourriture","Menu")
    Mainmenu.Closed = function()
        open = false 
    end 


    function OpenMenuShop()
        if open == false then
            open = true
            RageUI.Visible(Mainmenu,true)
            CreateThread(function()
                while open do 
                    RageUI.IsVisible(Mainmenu,function()
                        RageUI.Line()
                        RageUI.Button("Liste des Boissons",nil,{RightLabel = ">"},true,{}, boisson)
                        RageUI.Button("Liste des Nourritures",nil,{RightLabel = ">"},true,{}, nourriture)
                    end)
                    RageUI.IsVisible(boisson,function()
                        RageUI.Line()
                        for k, boisson in pairs(Config.boissons) do 
                            RageUI.Button(boisson.label,"~g~"..boisson.price.."$~s~",{RightLabel = ">"},true,{
                                onSelected = function()
                                    TriggerServerEvent('25:buyboissons',boisson.label, boisson.name, boisson.price)
                                end
                            })
                        end
                    end)
                    RageUI.IsVisible(nourriture,function()
                        RageUI.Line()
                        for k, nourriture in pairs(Config.nourritures) do 
                            RageUI.Button(nourriture.label,"~g~"..nourriture.price.."$~s~",{RightLabel = ">"},true,{
                                onSelected = function()
                                    TriggerServerEvent('25:buynourritures',nourriture.label, nourriture.name, nourriture.price)
                                end
                            })
                        end
                    end)
                    Wait(0)
                end
            end)
        end
    end
end)

---- Marker ---- 

Citizen.CreateThread(function()
    while true do
        local wait = 500
        for k,v in pairs(Config.PositionShop) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 2.0 then
                wait = 0
                DrawMarker(2, v.x, v.y, v.z, 5.0, 0.0, 0.0, 0.0,0.0,0.0, 0.4, 0.4, 0.4, 0, 255, 0, 255, false, false, p19, false) 
            end
            if dist <= 1.0 then
                wait = 0
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_TALK~ pour ~g~Intéragir~', 1) 
                if IsControlJustPressed(1,51) then
                    OpenMenuShop()
                end
            end
        end 
        Citizen.Wait(wait)
    end
end)

---- Blips ---- 

Citizen.CreateThread(function() 
    for k, v in pairs(Config.PositionShop) do 
        local blip = AddBlipForCoord(v.x, v.y, v.z) 
        SetBlipSprite  (blip, 59) 
        SetBlipDisplay (blip, 2) 
        SetBlipScale   (blip, 0.5) 
        SetBlipColour  (blip, 2) 
        SetBlipAsShortRange(blip, true) 
        BeginTextCommandSetBlipName('STRING') 
        AddTextComponentSubstringPlayerName("LTD") 
        EndTextCommandSetBlipName(blip) 
    end 
end)

                    
               

