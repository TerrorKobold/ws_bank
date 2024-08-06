ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('ws_bank:query', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = xPlayer.getName()
    local bank = ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)
    local cash = ESX.Math.GroupDigits(xPlayer.getAccount('money').money)
    cb(playerName, bank, cash)
end)

RegisterNetEvent('ws_bank:deposit')
AddEventHandler('ws_bank:deposit', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if amount <= xPlayer.getAccount('money').money then 
        xPlayer.removeAccountMoney('money', amount)
        xPlayer.addAccountMoney('bank', amount)
    else
        TriggerClientEvent('ox_lib:notify', source, {title = 'Nincsen elég pénzed.', showDuration = true, position = 'top', duration = 5000})
    end
end)

RegisterNetEvent('ws_bank:withdraw')
AddEventHandler('ws_bank:withdraw', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if amount <= xPlayer.getAccount('bank').money then 
        xPlayer.addAccountMoney('money', amount)
        xPlayer.removeAccountMoney('bank', amount)
    else
        TriggerClientEvent('ox_lib:notify', source, {title = 'Nincsen elég pénzed.', showDuration = true, position = 'top', duration = 5000})
    end
end)