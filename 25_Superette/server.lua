TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('25:buyboissons')
AddEventHandler('25:buyboissons', function(label,name,price)
    local player = ESX.GetPlayerFromId(source)
    local havemoney = player.getMoney() >= price

    if havemoney then 
        player.removeMoney(price)
        player.addInventoryItem(name,1)
        TriggerClientEvent('esx:showNotification', player.source, '+1 ~g~'..label)
    else 
        TriggerClientEvent('esx:showNotification', player.source, '~r~Vous n\'avez pas les moyens pour acheter cette objet !')
    end   
end)


RegisterServerEvent('25:buynourritures')
AddEventHandler('25:buynourritures', function(label,name,price)
    local player = ESX.GetPlayerFromId(source)
    local havemoney = player.getMoney() >= price

    if havemoney then 
        player.removeMoney(price)
        player.addInventoryItem(name,1)
        TriggerClientEvent('esx:showNotification', player.source, '+1 ~g~'..label)
    else 
        TriggerClientEvent('esx:showNotification', player.source, '~r~Vous n\'avez pas les moyens pour acheter cette objet !')
    end   
end)

