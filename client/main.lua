ESX = exports["es_extended"]:getSharedObject()

function OpenBank()
    ESX.TriggerServerCallback('ws_bank:query', function(playerName, bank, cash)
        lib.registerContext({
            id = 'bank:menu',
            title = Config.ServerName .. ' | Bank',
            options = {
            {
                title = 'Szia, ' .. playerName,
            },
            {
                title = 'Banki egyenleged: '..bank..'$ \n Készpénz: '..cash..'$',
                icon = 'wallet',
            },
            {
                title = 'Pénz befizetés',
                description = 'Pénz befizetés a bankba.',
                icon = 'plus',
                arrow = true,
                onSelect = function()
                    local input = lib.inputDialog('Pénz befizetés', {
                        {type = 'number', min = 1, label = 'Összeg:', icon = 'dollar'},
                    })

                    TriggerServerEvent('ws_bank:deposit', input[1])
                    OpenBank()
                end
            },
            {
                title = 'Pénz felvétel',
                description = 'Pénz felvétel a bankból.',
                icon = 'minus',
                arrow = true,
                onSelect = function()
                    local input = lib.inputDialog('Pénz felvétel', {
                        {type = 'number', min = 1, label = 'Összeg:', icon = 'dollar'},
                    })

                    TriggerServerEvent('ws_bank:withdraw', input[1])
                    OpenBank()
                end
            },
          }
        })
        lib.showContext('bank:menu')
    end)
end

function IsNearATM()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    for _, atmModel in pairs(Config.AtmModels) do
        local atmObject = GetClosestObjectOfType(playerCoords, 3.0, atmModel, false, false, false)
        if atmObject ~= 0 then
            return true
        end
    end
    
    return false
end

function IsNearBankLocation()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    for _, location in pairs(Config.BankLocations) do
        local dist = #(playerCoords - vector3(location.x, location.y, location.z))
        if dist <= 3.0 then
            return true
        end
    end
    
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsNearATM() or IsNearBankLocation() then
            lib.showTextUI('[E] - Bank', {
                icon = 'building-columns'
            })
            if IsControlJustReleased(0, 38) then
                OpenBank()
            end
        else
            lib.hideTextUI()
        end
    end
end)