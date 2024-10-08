local x, y, z = nil, nil, nil
local MarkerType = 27
local r,g,b = 255, 43, 0
local size = 1.0
local opacity = 200
local rotate = true


RegisterNUICallback('closeCopy', function(data, cb)
    SetNuiFocus(false,false)
    cb(coords)
end)

RegisterCommand("cds", function(source)
    x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    SendNUIMessage({
        open = true,
        x = x,
        y = y,
        z = z
    })
    SetNuiFocus(true, true)
end,false)