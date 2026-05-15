InTrunk = nil
TrunkVehicle = 0
MyServerId = GetPlayerServerId(PlayerId())
CameraTrunkId = -99
Offsets = {}

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    TriggerServerEvent("flake_trunks:init")
end)

AddEventHandler("flake_trunks:enterTrunk", function(vehicle)
    if DoesEntityExist(vehicle) then
        if not IsVehicleNpc(vehicle) then
            if IsVehicleOpen(vehicle) then
                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                if NetworkDoesNetworkIdExist(netId) then
                    if ProgressBar(_L("getIntoTrunk"), Config.GetIntoTrunkProgressBar.duration, Config.GetIntoTrunkProgressBar.canCancel) then
                        GetInTrunk(vehicle, netId)
                    end
                end
            end
        end
    else
        HudAddNotification(_L("cannotGetIntoTrunk"))
    end
end)

AddEventHandler("flake_trunks:exitTrunk", function(vehicle)
    if vehicle ~= nil then
        if DoesEntityExist(vehicle) then
            if IsVehicleOpen(vehicle) then
                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                if NetworkDoesNetworkIdExist(netId) then
                    if CheckVehicleSpeed(vehicle) then
                        if CanExitVehicleTrunk(vehicle) then
                            if ProgressBar(_L("getOutOfTrunk"), Config.ExitTrunkProgressBar.duration, Config.ExitTrunkProgressBar.canCancel) then
                                GetOutTrunk(vehicle, netId)
                            end
                        end
                    else
                        HudAddNotification(_L("vehicleIsTooFast"))
                    end
                end
            end
        end
    end
end)

AddEventHandler("flake_trunks:putInClosest", function(targetPed)
    if GetEntityType(targetPed) ~= 2 then
        local _, closestPed = GetClosestPlayer()
        if not closestPed or not DoesEntityExist(closestPed) then return end
        targetPed = closestPed
    end

    local playerIndex = NetworkGetPlayerIndexFromPed(targetPed)
    if playerIndex == -1 then
        goto lbl_104
    end

    local targetServerId = GetPlayerServerId(playerIndex)
    local targetState = Player(targetServerId).state
    if targetState then
        local wasabiDead = targetState.dead
        local isDown = targetState.SFTRUNKS_DEAD or targetState.SFTRUNKS_HANDCUFFED
                       or wasabiDead == "dead" or wasabiDead == "laststand"
        if isDown then
            local closestVehicle = GetClosestVehicle_T(false)
            if closestVehicle ~= nil then
                if DoesEntityExist(closestVehicle) then
                    if GetVehicleDoorLockStatus(closestVehicle) == 2 then
                        HudAddNotification(_L("vehicleIsLocked"))
                        return
                    end
                    if not IsVehicleNpc(closestVehicle) then
                        if IsVehicleOpen(closestVehicle) then
                            if ProgressBar(_L("puttingPlayerIntoTrunk"), Config.PutPlayerIntoTrunkProgressBar.duration, Config.PutPlayerIntoTrunkProgressBar.canCancel) then
                                local netId = NetworkGetNetworkIdFromEntity(closestVehicle)
                                if NetworkDoesNetworkIdExist(netId) then
                                    TriggerServerEvent("flake_trunks:putInClosest", targetServerId, netId)
                                end
                            end
                        else
                            HudAddNotification(_L("cantPutPlayerIntoThatVehicle"))
                        end
                    end
                end
            end
        end
    end

    ::lbl_104::
end)

AddEventHandler("flake_trunks:takeOutPlayer", function(vehicle)
    if not IsVehicleOpen(vehicle) then
        HudAddNotification(_L("vehicleIsLocked"))
        return
    end
    local trunk = Entity(vehicle).state.Trunk
    if trunk ~= nil then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if ProgressBar(_L("pullingPlayerOutOfTrunk"), Config.GetPlayerOutOfTrunkProgressBar.duration, Config.GetPlayerOutOfTrunkProgressBar.canCancel) then
            if NetworkDoesNetworkIdExist(netId) then
                if IsVehicleOpen(vehicle) then
                    TriggerServerEvent("flake_trunks:takeOutPlayer", netId)
                end
            end
        end
    end
end)

RegisterNetEvent("flake_trunks:getIn")
AddEventHandler("flake_trunks:getIn", function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        GetInTrunk(vehicle, netId)
    end
end)

RegisterNetEvent("flake_trunks:getOut")
AddEventHandler("flake_trunks:getOut", function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        GetOutTrunk(vehicle, netId)
    end
end)

RegisterNetEvent("flake_trunks:getOffsets")
AddEventHandler("flake_trunks:getOffsets", function(offsets)
    Offsets = offsets
    local count = 0
    for _ in pairs(Offsets) do count = count + 1 end
    print(("[flake_trunks] Received %d vehicle offsets from server"):format(count))
end)

RegisterNetEvent("flake_trunks:setNewOffset")
AddEventHandler("flake_trunks:setNewOffset", function(model, offset, rotation)
    Offsets[model] = { o = offset, r = rotation }
end)

GetClosestVehicle_T = function(requireOffset, maxDistance)
    local playerPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
    local closestDist = nil
    local closestId = nil
    local closestVeh = nil
    local vehicles = GetGamePool("CVehicle")

    for i = 1, #vehicles do
        local veh = vehicles[i]
        local model = GetEntityModel(veh)
        local offset = Offsets[model]

        if offset ~= nil or requireOffset == false then
            local vehPos = GetEntityCoords(veh)
            local dist = #(playerPos - vehPos)

            if maxDistance == nil then
                local checkDist = closestDist or 5
                if dist < checkDist then
                    closestDist = dist
                    closestVeh = veh
                end
            elseif maxDistance > dist then
                closestDist = dist
                closestVeh = veh
            end
        end
    end

    return closestVeh
end

GetClosestPlayer = function()
    local myPed = PlayerPedId()
    local players = GetActivePlayers()
    local myPos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 1.0, 0.0)
    local closestDist = nil
    local closestPlayer = nil
    local closestPed = nil
    local myId = PlayerId()

    for i = 1, #players do
        local player = players[i]
        if player ~= myId then
            local ped = GetPlayerPed(player)
            local pedPos = GetEntityCoords(ped)
            local dist = #(myPos - pedPos)
            local checkDist = closestDist or 2

            if dist < checkDist then
                if not IsPedInAnyVehicle(ped, true) then
                    closestDist = dist
                    closestPlayer = player
                    closestPed = ped
                end
            end
        end
    end

    local serverId = GetPlayerServerId(closestPlayer)
    return serverId, closestPed
end

GetInTrunk = function(vehicle, netId)
    if DoesEntityExist(vehicle) then
        if NetworkDoesNetworkIdExist(netId) then
            local state = Entity(vehicle).state
            if state then
                if state.Trunk == nil then
                    SetStateInTrunk(netId, true, vehicle)
                end
            end
        end
    end
end

GetOutTrunk = function(vehicle, netId)
    if DoesEntityExist(vehicle) then
        if NetworkDoesNetworkIdExist(netId) then
            SetStateInTrunk(netId, nil, vehicle)
        end
    end
end

SetStateInTrunk = function(vehicleNetId, inTrunk, vehicle)
    local myPed = PlayerPedId()
    TriggerServerEvent("flake_trunks:inTrunk", vehicleNetId, inTrunk)
    InTrunk = inTrunk
    TrunkVehicle = vehicle

    if inTrunk then
        LocalPlayer.state:set("InTrunk", vehicleNetId, true)
    else
        LocalPlayer.state:set("InTrunk", nil, true)
    end

    if inTrunk then
        local offset = Offsets[GetEntityModel(vehicle)]
        if not offset then
            local minDims, maxDims = GetModelDimensions(GetEntityModel(vehicle))
            offset = {
                o = { x = 0.0, y = minDims.y * 0.70, z = 0.25 },
                r = { x = 0.0, y = 0.0, z = 180.0 },
            }
        end
        SetPedProofInTrunk(myPed, true)
        SetPedCanRagdoll(myPed, false)
        ClearPedTasksImmediately(myPed)
        Citizen.Wait(100)
        SetupCameraTrunk(vehicle)
        -- Attach to vehicle BEFORE playing animation so the attachment wins.
        -- lockX/Y/Z = true prevents root motion from dragging the ped to the ground.
        AttachEntityToEntity(myPed, vehicle, 0,
            offset.o.x, offset.o.y, offset.o.z,
            offset.r.x, offset.r.y, offset.r.z,
            true, true, false, true, 1, true)
        FreezeEntityPosition(myPed, true)
        RequestAnimDict2("amb@world_human_sunbathe@female@back@base")
        TaskPlayAnim(myPed, "amb@world_human_sunbathe@female@back@base", "base", 8.0, -8.0, -1, 1, 0.0, true, true, true)
        SetEntityInvincible(myPed, true)
    else
        DetachPed()
        SetEntityInvincible(myPed, false)
        if DoesEntityExist(vehicle) then
            SetPedProofInTrunk(myPed, false)
            SetPedCanRagdoll(myPed, true)
            local minDims, maxDims = GetModelDimensions(GetEntityModel(vehicle))
            local spawnPos = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, minDims.y - 1.0, 0.1)
            SetEntityCoords(myPed, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false, false)
            PlaceObjectOnGroundProperly(myPed)
        end
        DisableCameraTrunk()
        TrunkVehicle = 0
    end
end

SetupCameraTrunk = function(entityToTrack, vehicleForHeading)
    if CameraTrunkId ~= nil then
        if DoesCamExist(CameraTrunkId) then
            goto lbl_98
        end
    end

    CameraTrunkId = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    TriggerEvent("flake_trunks:isUsingCamera", true)
    SetCamActive(CameraTrunkId, true)
    RenderScriptCams(true, true, 1000, true, true)

    local myPed = PlayerPedId()
    local dist = Config.Camera.DistanceFromCar
    if entityToTrack == myPed then dist = 2.0 end

    local pitch = 15.0
    local yaw = -(GetEntityHeading(TrunkVehicle) - 180.0)
    if vehicleForHeading ~= nil then
        yaw = -(GetEntityHeading(vehicleForHeading) - 180.0)
    end

    local inputH = 0.0
    local inputV = 0.0
    local sensitivity = Config.Camera.FreeCameraSpeed
    local deltaFactor = 1.0
    local rightX = 0.0
    local rightY = 0.0
    local lookX = 0.0
    local lookY = 0.0
    local camX = 0.0
    local camY = 0.0
    local camZ = 0.0
    local prevCamZ = 0.0
    local prevPitch = 0.0

    local trackedPos = vec3(0.0, 0.0, 0.0)
    local isStationary = Config.Camera.Stationary
    local stationaryCamPos = vec3(0.0, 0.0, 0.0)

    local minDims, maxDims = GetModelDimensions(GetEntityModel(TrunkVehicle))

    if not isStationary then
        dist = dist + maxDims.y
    end

    Citizen.CreateThreadNow(function()
        while true do
            if CameraTrunkId == nil then break end

            trackedPos = GetEntityCoords(entityToTrack)

            if isStationary then
                stationaryCamPos = GetOffsetFromEntityInWorldCoords(entityToTrack, 0.0, minDims.y - dist, maxDims.z + Config.Camera.StationaryHeight)
                SetCamCoord(CameraTrunkId, stationaryCamPos.x, stationaryCamPos.y, stationaryCamPos.z)
                PointCamAtCoord(CameraTrunkId, trackedPos.x, trackedPos.y, trackedPos.z)
            else
                EnableControlAction(0, 3, true)
                EnableControlAction(0, 4, true)
                EnableControlAction(0, 5, true)
                EnableControlAction(0, 6, true)

                rightX = GetControlNormal(0, 6)
                rightY = GetControlNormal(0, 5)
                lookX = GetControlNormal(0, 3)
                lookY = GetControlNormal(0, 4)

                inputH = rightX + rightY
                inputV = lookX + lookY

                local vehRot = GetEntityRotation(TrunkVehicle, 2)
                deltaFactor = sensitivity * GetFrameTime()

                if not IsNuiFocused() then
                    pitch = pitch + inputV * deltaFactor
                    yaw = yaw + inputH * deltaFactor
                end

                pitch = math.max(-70.0, math.min(35.0, pitch))
                yaw = math.max(-180.0, math.min(180.0, yaw))

                if yaw > 179.999 then yaw = -179.999 end
                if yaw < -179.999 then yaw = 179.999 end

                if vehRot.x < 0 then
                    pitch = math.max(math.abs(vehRot.x) + 5.0, math.min(35.0, pitch))
                end

                camX = trackedPos.x + math.sin(math.rad(yaw)) * dist
                camY = trackedPos.y + math.cos(math.rad(yaw)) * dist
                camZ = trackedPos.z + math.sin(math.rad(pitch)) * dist

                if camZ < trackedPos.z then
                    camZ = prevCamZ
                    pitch = prevPitch
                end

                prevCamZ = camZ
                prevPitch = pitch

                SetCamCoord(CameraTrunkId, camX, camY, camZ)
                PointCamAtCoord(CameraTrunkId, trackedPos.x, trackedPos.y, trackedPos.z)
            end

            Citizen.Wait(0)
        end
    end)

    ::lbl_98::
end

DisableCameraTrunk = function()
    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(CameraTrunkId, false)
    CameraTrunkId = nil
    TriggerEvent("flake_trunks:isUsingCamera", false)
end

DetachPed = function()
    local myPed = PlayerPedId()
    FreezeEntityPosition(myPed, false)
    ClearPedTasks(myPed)
    DetachEntity(myPed, false, false)
end

RequestAnimDict2 = function(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end
end

SendNUIAppAction = function(action, payload)
    SendNUIMessage({
        event = "sendAppEvent",
        app = "os",
        action = action,
        payload = payload,
    })
end

PlayTrunkAnim = function()
    local myPed = PlayerPedId()
    SetPedCanRagdoll(myPed, false)
    SetEntityInvincible(myPed, true)
    ClearPedTasksImmediately(myPed)
    RequestAnimDict2("amb@world_human_sunbathe@female@back@base")
    TaskPlayAnim(myPed, "amb@world_human_sunbathe@female@back@base", "base", 8.0, -8.0, -1, 1, 0.0, true, true, true)
end

local inTrunkThread = false
AddStateBagChangeHandler("InTrunk", ("player:%s"):format(MyServerId), function(bagName, key, value, reserved, replicated)
    if value ~= nil then
        if not inTrunkThread then
            inTrunkThread = true
            Citizen.CreateThreadNow(function()
                local myPed = PlayerPedId()
                local ticker = 0

                while true do
                    if not InTrunk then break end

                    ticker = ticker + 1

                    SetPedCanRagdoll(myPed, false)
                    SetEntityInvincible(myPed, true)
                    FreezeEntityPosition(myPed, true)
                    if not IsEntityPlayingAnim(myPed, "amb@world_human_sunbathe@female@back@base", "base", 3) then
                        PlayTrunkAnim()
                        Citizen.Wait(50)
                    end

                    DisableAllControlActions2()

                    for i = 1, #Config.EnabledKeysWhileInTrunk do
                        EnableControlAction(0, Config.EnabledKeysWhileInTrunk[i], true)
                    end

                    if ticker > 120 then
                        ticker = 0
                        if DoesEntityExist(TrunkVehicle) then
                            local pedPos = GetEntityCoords(myPed)
                            local vehPos = GetEntityCoords(TrunkVehicle)
                            if #(pedPos - vehPos) > 30.0 then
                                SetStateInTrunk(LocalPlayer.state.InTrunk, nil, TrunkVehicle)
                                break
                            end

                            if IsEntityDead(TrunkVehicle) then
                                SetStateInTrunk(LocalPlayer.state.InTrunk, nil, TrunkVehicle)
                                break
                            end

                            if GetEntitySubmergedLevel(TrunkVehicle) > 0.9 then
                                SetStateInTrunk(LocalPlayer.state.InTrunk, nil, TrunkVehicle)
                                break
                            end
                        else
                            SetStateInTrunk(LocalPlayer.state.InTrunk, nil, TrunkVehicle)
                        end
                    end

                    Citizen.Wait(0)
                end

                inTrunkThread = false
            end)
        end
    end
end)

if Config.DevMode then
    RegisterCommand("trunk_create", function()
        local myPed = PlayerPedId()
        local vehicle = GetClosestVehicle_T(false)
        TriggerEvent("flake_trunks:inEditor", true)
        SendNUIAppAction("setKeysVisible", true)
        SendNUIAppAction("setKeys", {
            {
                keys = {
                    Config.OffsetEditorKeys.Position.Forward[2],
                    Config.OffsetEditorKeys.Position.Backward[2],
                    Config.OffsetEditorKeys.Position.Left[2],
                    Config.OffsetEditorKeys.Position.Right[2],
                    Config.OffsetEditorKeys.Position.Up[2],
                    Config.OffsetEditorKeys.Position.Down[2],
                },
                label = _L("position"),
            },
            {
                keys = {
                    Config.OffsetEditorKeys.Rotation.XAxis.Plus[2],
                    Config.OffsetEditorKeys.Rotation.XAxis.Minus[2],
                    Config.OffsetEditorKeys.Rotation.YAxis.Plus[2],
                    Config.OffsetEditorKeys.Rotation.YAxis.Minus[2],
                    Config.OffsetEditorKeys.Rotation.ZAxis.Plus[2],
                    Config.OffsetEditorKeys.Rotation.ZAxis.Minus[2],
                },
                label = _L("rotation"),
            },
            {
                keys = { Config.OffsetEditorKeys.OpenAllVehicleDoors[2] },
                label = _L("openAllVehicleDoors"),
            },
            {
                keys = { Config.OffsetEditorKeys.Confirm[2] },
                label = _L("confirm"),
            },
            {
                keys = { Config.OffsetEditorKeys.Cancel[2] },
                label = _L("cancel"),
            },
        })

        SetupCameraTrunk(myPed, vehicle)
        RequestAnimDict2("amb@world_human_sunbathe@female@back@base")
        TaskPlayAnim(myPed, "amb@world_human_sunbathe@female@back@base", "base", 8.0, -8.0, -1, 1, 0.0, true, true, true)

        local minDims, maxDims = GetModelDimensions(GetEntityModel(vehicle))

        local ox = 0.0
        local oy = minDims.y - 0.3
        local oz = 0.0
        local rx = 0.0
        local ry = 0.0
        local rz = 0.0

        AttachEntityToEntity(myPed, vehicle, 0, ox, oy, oz, rx, ry, rz, true, true, false, true, 1, true)

        local changed = false
        local doorsOpen = false
        local confirmed = false

        DisableIdleCamera(false)

        while true do
            changed = false
            DisableAllControlActions2()
            EnableControlAction(1, 270, true)
            EnableControlAction(1, 271, true)
            EnableControlAction(1, 272, true)
            EnableControlAction(1, 273, true)
            EnableControlAction(1, 1, true)
            EnableControlAction(1, 2, true)
            EnableControlAction(1, 3, true)
            EnableControlAction(1, 4, true)
            EnableControlAction(1, 5, true)
            EnableControlAction(1, 6, true)

            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Position.Right[1]) then
                ox = ox + 0.005
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Position.Left[1]) then
                ox = ox - 0.005
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Position.Forward[1]) then
                oy = oy + 0.005
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Position.Backward[1]) then
                oy = oy - 0.005
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Position.Up[1]) then
                oz = oz + 0.005
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Position.Down[1]) then
                oz = oz - 0.005
                changed = true
            end

            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Rotation.XAxis.Plus[1]) then
                rx = rx + 0.5
                if rx > 180.0 then rx = 0.0 end
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Rotation.XAxis.Minus[1]) then
                rx = rx - 0.5
                if rx < -180.0 then rx = 0.0 end
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Rotation.YAxis.Plus[1]) then
                ry = ry + 0.5
                if ry > 180.0 then ry = 0.0 end
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Rotation.YAxis.Minus[1]) then
                ry = ry - 0.5
                if ry < -180.0 then ry = 0.0 end
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Rotation.ZAxis.Plus[1]) then
                rz = rz + 0.5
                if rz > 180.0 then rz = 0.0 end
                changed = true
            end
            if IsDisabledControlPressed(0, Config.OffsetEditorKeys.Rotation.ZAxis.Minus[1]) then
                rz = rz - 0.5
                if rz < -180.0 then rz = 0.0 end
                changed = true
            end

            if IsDisabledControlJustPressed(0, Config.OffsetEditorKeys.Confirm[1]) then
                confirmed = true
                break
            end
            if IsDisabledControlJustPressed(0, Config.OffsetEditorKeys.Cancel[1]) then
                confirmed = false
                break
            end

            if IsDisabledControlJustPressed(0, Config.OffsetEditorKeys.OpenAllVehicleDoors[1]) then
                if not doorsOpen then
                    doorsOpen = true
                    for door = 0, 5 do
                        SetVehicleDoorOpen(vehicle, door, false, false)
                    end
                else
                    doorsOpen = false
                    for door = 0, 5 do
                        SetVehicleDoorShut(vehicle, door, false)
                    end
                end
            end

            if changed then
                AttachEntityToEntity(myPed, vehicle, 0, ox, oy, oz, rx, ry, rz, true, true, false, true, 1, true)
                TaskPlayAnim(myPed, "amb@world_human_sunbathe@female@back@base", "base", 8.0, -8.0, -1, 1, 0.0, true, true, true)
            end

            Citizen.Wait(0)
        end

        if doorsOpen then
            for door = 0, 5 do
                SetVehicleDoorShut(vehicle, door, false)
            end
        end

        Citizen.CreateThreadNow(function()
            for _ = 1, 40 do
                DisableControlAction(0, 177, true)
                DisableControlAction(0, 200, true)
                DisableControlAction(0, 202, true)
                DisableControlAction(0, 322, true)
                Citizen.Wait(0)
            end
        end)

        if confirmed then
            TriggerServerEvent("flake_trunks:saveConfig", GetEntityModel(vehicle), vec3(ox, oy, oz), vec3(rx, ry, rz), GetAllVehicleModels())
        end

        DisableCameraTrunk()
        DetachEntity(myPed, false, false)
        ClearPedTasks(myPed)

        local spawnPos = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, maxDims.y - 1.0, 0.1)
        SetEntityCoords(myPed, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false, false)
        PlaceObjectOnGroundProperly(myPed)

        SendNUIAppAction("setKeysVisible", false)
        TriggerEvent("flake_trunks:inEditor", false)
    end, false)
end

RegisterCommand("trunkdebug", function()
    local count = 0
    for _ in pairs(Offsets) do count = count + 1 end
    print(("[flake_trunks] Offsets loaded: %d"):format(count))

    local vehicle = GetClosestVehicle_T(false)
    if not vehicle then
        print("[flake_trunks] No vehicle nearby")
        return
    end

    local model = GetEntityModel(vehicle)
    local hasOffset = Offsets[model] ~= nil
    local lockStatus = GetVehicleDoorLockStatus(vehicle)
    local isNpc = IsVehicleNpc(vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    local netExists = NetworkDoesNetworkIdExist(netId)
    local trunkState = Entity(vehicle).state.Trunk

    print(("[flake_trunks] Nearest vehicle model hash: %s"):format(model))
    print(("[flake_trunks]   Has offset entry : %s"):format(tostring(hasOffset)))
    print(("[flake_trunks]   Lock status      : %d (1=open, 2=locked)"):format(lockStatus))
    print(("[flake_trunks]   Is NPC vehicle   : %s"):format(tostring(isNpc)))
    print(("[flake_trunks]   Net ID valid     : %s"):format(tostring(netExists)))
    print(("[flake_trunks]   InTrunk global   : %s"):format(tostring(InTrunk)))
    print(("[flake_trunks]   Trunk state bag  : %s"):format(tostring(trunkState)))
end, false)

RegisterCommand("trunkwatchdog", function()
    local running = true

    -- Stop with /trunkwatchdog_stop
    RegisterCommand("trunkwatchdog_stop", function()
        running = false
        print("[flake_trunks:watchdog] Stopped.")
    end, false)

    Citizen.CreateThread(function()
        print("[flake_trunks:watchdog] Started. Run /trunkwatchdog_stop to end.")
        local lastAnim     = ""
        local lastAttached = false
        local lastFrozen   = false
        local lastDead     = false
        local lastFatal    = false
        local lastWasabi   = "nil"
        local lastInTrunk  = tostring(InTrunk)
        local lastSFDead   = tostring(LocalPlayer.state.SFTRUNKS_DEAD)
        local lastSFCuffed = tostring(LocalPlayer.state.SFTRUNKS_HANDCUFFED)

        while running do
            local ped = PlayerPedId()

            local anim     = IsEntityPlayingAnim(ped, "amb@world_human_sunbathe@female@back@base", "base", 3)
            local attached = IsEntityAttached(ped)
            local frozen   = IsEntityPositionFrozen(ped)
            local dead     = IsEntityDead(ped)
            local fatal    = IsPedFatallyInjured(ped)
            local inTrunk  = tostring(InTrunk)
            local sfDead   = tostring(LocalPlayer.state.SFTRUNKS_DEAD)
            local sfCuffed = tostring(LocalPlayer.state.SFTRUNKS_HANDCUFFED)

            -- Read wasabi state bag if available
            local wasabi = "N/A"
            if GetResourceState("wasabi_ambulance") ~= "missing" then
                local ok, val = pcall(function()
                    return exports.wasabi_ambulance:isPlayerDead()
                end)
                wasabi = ok and tostring(val) or "err"
            end

            -- Only print when something actually changes
            local changed = (
                tostring(anim)     ~= tostring(lastAnim)     or
                tostring(attached) ~= tostring(lastAttached) or
                tostring(frozen)   ~= tostring(lastFrozen)   or
                tostring(dead)     ~= tostring(lastDead)     or
                tostring(fatal)    ~= tostring(lastFatal)    or
                inTrunk            ~= lastInTrunk            or
                sfDead             ~= lastSFDead             or
                sfCuffed           ~= lastSFCuffed           or
                wasabi             ~= lastWasabi
            )

            if changed then
                print(("^3[watchdog] ^7InTrunk=^2%s^7 | TrunkAnim=^2%s^7 | Attached=^2%s^7 | Frozen=^2%s^7"):format(
                    inTrunk, tostring(anim), tostring(attached), tostring(frozen)))
                print(("^3[watchdog] ^7Dead=^1%s^7 | FatalInj=^1%s^7 | SFTRUNKS_DEAD=^1%s^7 | Cuffed=%s | WasabiDead=^1%s^7"):format(
                    tostring(dead), tostring(fatal), sfDead, sfCuffed, wasabi))
                print("^3[watchdog] ^8--- change detected ---^7")
            end

            lastAnim     = tostring(anim)
            lastAttached = tostring(attached)
            lastFrozen   = tostring(frozen)
            lastDead     = tostring(dead)
            lastFatal    = tostring(fatal)
            lastInTrunk  = inTrunk
            lastSFDead   = sfDead
            lastSFCuffed = sfCuffed
            lastWasabi   = wasabi

            Citizen.Wait(100)
        end
    end)
end, false)

RegisterCommand("trunkoccupantwatchdog", function()
    local running = true

    RegisterCommand("trunkoccupantwatchdog_stop", function()
        running = false
        print("[flake_trunks:occupant-watchdog] Stopped.")
    end, false)

    Citizen.CreateThread(function()
        print("[flake_trunks:occupant-watchdog] Started. Watching for trunk occupant...")

        local lastAnim     = ""
        local lastAttached = ""
        local lastFrozen   = ""
        local lastDead     = ""
        local lastFatal    = ""
        local lastWasabi   = ""
        local lastOccupant = ""

        while running do
            local vehicle = GetClosestVehicle_T(false, 10.0)
            local occupantServerId = nil
            local occupantPed = nil

            if vehicle and DoesEntityExist(vehicle) then
                local trunk = Entity(vehicle).state.Trunk
                if trunk ~= nil then
                    occupantServerId = trunk
                    -- Find the ped from server id
                    local players = GetActivePlayers()
                    for _, p in ipairs(players) do
                        if GetPlayerServerId(p) == trunk then
                            occupantPed = GetPlayerPed(p)
                            break
                        end
                    end
                end
            end

            if occupantPed and DoesEntityExist(occupantPed) then
                local anim     = IsEntityPlayingAnim(occupantPed, "amb@world_human_sunbathe@female@back@base", "base", 3)
                local attached = IsEntityAttached(occupantPed)
                local frozen   = IsEntityPositionFrozen(occupantPed)
                local dead     = IsEntityDead(occupantPed)
                local fatal    = IsPedFatallyInjured(occupantPed)
                local occ      = tostring(occupantServerId)

                -- wasabi state bag on the occupant
                local wasabi = "N/A"
                if GetResourceState("wasabi_ambulance") ~= "missing" then
                    local ok, val = pcall(function()
                        return Player(occupantServerId).state.dead
                    end)
                    wasabi = ok and tostring(val) or "err"
                end

                local changed = (
                    tostring(anim)     ~= lastAnim     or
                    tostring(attached) ~= lastAttached or
                    tostring(frozen)   ~= lastFrozen   or
                    tostring(dead)     ~= lastDead     or
                    tostring(fatal)    ~= lastFatal    or
                    wasabi             ~= lastWasabi   or
                    occ                ~= lastOccupant
                )

                if changed then
                    print(("^5[occupant:%s] ^7TrunkAnim=^2%s^7 | Attached=^2%s^7 | Frozen=^2%s^7"):format(
                        occ, tostring(anim), tostring(attached), tostring(frozen)))
                    print(("^5[occupant:%s] ^7Dead=^1%s^7 | FatalInj=^1%s^7 | WasabiStateBag=^1%s^7"):format(
                        occ, tostring(dead), tostring(fatal), wasabi))
                    print("^5[occupant] ^8--- change ---^7")
                end

                lastAnim     = tostring(anim)
                lastAttached = tostring(attached)
                lastFrozen   = tostring(frozen)
                lastDead     = tostring(dead)
                lastFatal    = tostring(fatal)
                lastWasabi   = wasabi
                lastOccupant = occ
            else
                if lastOccupant ~= "" then
                    print("^5[occupant-watchdog] ^7No occupant in nearby trunk.")
                    lastOccupant = ""
                end
            end

            Citizen.Wait(100)
        end
    end)
end, false)
