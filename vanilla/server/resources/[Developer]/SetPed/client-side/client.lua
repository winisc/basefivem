-- REGISTER_COMMAND
RegisterCommand("skin",function()
    local model = "a_f_m_bodybuild_01"

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(500)
        print("Carregou o Modelo")
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)

end, false)