-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {{ -- LOJA 1 
		distance = 20,
		coords = { 2463.988037109375, 3769.500244140625, 41.38849639892578 },
		model = { 0xB1B196B2,"ig_floyd" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if not IsPedInAnyVehicle(ped) then
					if localPeds[k] == nil then
						local mHash = GetHashKey(v["model"][2])

						RequestModel(mHash)
						while not HasModelLoaded(mHash) do
							Citizen.Wait(1)
						end

						if HasModelLoaded(mHash) then
							localPeds[k] = CreatePed(4,v["model"][2],v["coords"][1],v["coords"][2],v["coords"][3] - 1,3374176,false,false)

							SetPedComponentVariation(localPeds[k],9,1,0,1)

							if v["model"][2] == "frentista" then
								SetPedPropIndex(localPeds[k],0,0,0,1)
								SetPedComponentVariation(localPeds[k],4,0,0,1)
								SetPedComponentVariation(localPeds[k],3,0,0,1)
								SetPedComponentVariation(localPeds[k],8,0,0,1)
								SetPedComponentVariation(localPeds[k],9,0,0,1)
								SetPedComponentVariation(localPeds[k],11,0,0,1)
								SetPedComponentVariation(localPeds[k],6,0,0,1)
								SetPedComponentVariation(localPeds[k],1,0,0,1)
								SetPedComponentVariation(localPeds[k],10,0,0,1)
								SetPedComponentVariation(localPeds[k],7,0,0,1)
								SetPedComponentVariation(localPeds[k],2,0,0,1)
							end

							if v["logitech"] then
								SetPedPropIndex(localPeds[k],0,-1,0,1)
								SetPedComponentVariation(localPeds[k],4,2,0,1)
								SetPedComponentVariation(localPeds[k],3,0,0,1)
								SetPedComponentVariation(localPeds[k],8,-1,0,1)
								SetPedComponentVariation(localPeds[k],9,0,0,1)
								SetPedComponentVariation(localPeds[k],11,0,0,1)
								SetPedComponentVariation(localPeds[k],6,0,0,1)
								SetPedComponentVariation(localPeds[k],1,0,0,1)
								SetPedComponentVariation(localPeds[k],10,0,0,1)
								SetPedComponentVariation(localPeds[k],7,0,0,1)
								SetPedComponentVariation(localPeds[k],2,0,0,1)
							end

							SetPedArmour(localPeds[k],100)
							SetEntityInvincible(localPeds[k],true)
							FreezeEntityPosition(localPeds[k],true)
							SetEntityHeading(localPeds[k],v["coords"][4])
							SetBlockingOfNonTemporaryEvents(localPeds[k],true)

							SetModelAsNoLongerNeeded(mHash)
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
