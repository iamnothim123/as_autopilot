RegisterCommand(
    "autopilot", 
    function(source, args, rawCommand)
        print("Thinking")
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local waypointBlip = GetFirstBlipInfoId(8)
        
            if DoesBlipExist(waypointBlip) then
                local coord = GetBlipInfoIdCoord(waypointBlip)
                local x, y, z = coord.x, coord.y, coord.z
                TaskVehicleDriveToCoord(
                    ped, vehicle, x, y, z, 30.0, 0, GetEntityModel(vehicle), 786603, 1.0, true)

                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(500)
                        local vehiclePos = GetEntityCoords(vehicle)
                        local distance = Vdist(vehiclePos.x, vehiclePos.y, vehiclePos.z, x, y, z)
                        
                        if distance <= 10.0 then 
                            print("Arrived at destination!")
                            ClearPedTasks(ped) 
                            break 
                        end
                    end
                end)
            end
        else
            print("You must be in a vehicle to use autopilot!")
        end
    end, 
    false
)
