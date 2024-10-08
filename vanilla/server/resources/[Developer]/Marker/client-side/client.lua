local markerList = {
    { -- LOJA 1
        coords = { 3063.97021484375, 5608.8798828125, 209.23875427246097 },
        message = {"Pressione E para interagir"},
        type = {"flores"}
    },
    { -- LOJA 2
        coords = { 714.05078125, 4146.4287109375, 35.77922821044922 },
        message = {"Pressione E para interagir"},
        type = {"store"}
    },

}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        local time = 1000 -- tempo de espera padrão

        for k, v in pairs(markerList) do
            local distancia = #(playerCoords - vector3(v["coords"][1], v["coords"][2], v["coords"][3]))
            
            if distancia < 10 then
                time = 1 -- diminui o tempo de espera se estiver perto
                DrawText3D(v["coords"][1], v["coords"][2], v["coords"][3], v["message"][1])
                
                if distancia < 2 then
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('loja:interagir', v["type"][1])
                    end
                end
            end
        end

        Wait(time)
    end
end)



RegisterNetEvent('loja:interagir')
AddEventHandler('loja:interagir', function(type)
    if(type == "flores") then
        print("Interagiu com a loja flor!")
        TriggerEvent('abrirLoja')
    end
    if(type == "store") then
        print("Interagiu com a loja store!")
    end
end)


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


RegisterNetEvent('loja:interagir')
AddEventHandler('loja:interagir', function()
    SendNUIMessage({
        action = "open"
    })
    
    SetNuiFocus(true, true)
end, false)

RegisterNUICallback('fecharNui', function(data, cb)
    SetNuiFocus(false, false)   
    cb('ok')
end)