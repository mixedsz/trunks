local res = GetCurrentResourceName()
local isHandcuffed = false
local isDragged = false

---@param name string
---@param icon string
---@param label string
---@param action function
---@param canInteract function
RegisterVehicleInteraction = function(name, icon, label, action, canInteract)
    local oxtState   = GetResourceState("ox_target")
    local qtState    = GetResourceState("qtarget")
    local qbState    = GetResourceState("qb-target")
    print(("[flake_trunks] RegisterVehicleInteraction(%s) | ox_target=%s qtarget=%s qb-target=%s"):format(name, oxtState, qtState, qbState))

    if oxtState ~= "missing" then
        local ok, err = pcall(function()
            exports.ox_target:addGlobalVehicle({
                {
                    name = res .. name,
                    icon = icon,
                    label = label,
                    onSelect = function(data)
                        action(data.entity)
                    end,
                    canInteract = function(entity)
                        return NetworkGetEntityIsNetworked(entity) and canInteract(entity)
                    end,
                    distance = 2.0,
                }
            })
        end)
        if not ok then
            print(("[flake_trunks] ox_target addGlobalVehicle ERROR: %s"):format(err))
        else
            print(("[flake_trunks] ox_target addGlobalVehicle OK: %s"):format(name))
        end
    elseif GetResourceState("qtarget") ~= "missing" then
        exports["qtarget"]:Vehicle({
            options = {
                {
                    name = res .. name,
                    icon = icon,
                    label = label,
                    action = function(data)
                        if type(data) == "table" then
                            action(data.entity)
                        else
                            action(data)
                        end
                    end,
                    canInteract = function(data)
                        if type(data) == "table" then
                            return NetworkGetEntityIsNetworked(data.entity) and canInteract(data.entity)
                        else
                            return NetworkGetEntityIsNetworked(data) and canInteract(data)
                        end
                    end
                }
            },
            distance = 2.0
        })
    elseif GetResourceState("qb-target") ~= "missing" then
        exports["qb-target"]:AddGlobalVehicle({
            options = {
                {
                    name = res .. name,
                    icon = icon,
                    label = label,
                    action = function(data)
                        if type(data) == "table" then
                            action(data.entity)
                        else
                            action(data)
                        end
                    end,
                    canInteract = function(data)
                        if type(data) == "table" then
                            return NetworkGetEntityIsNetworked(data.entity) and canInteract(data.entity)
                        else
                            return NetworkGetEntityIsNetworked(data) and canInteract(data)
                        end
                    end
                }
            },
            distance = 3.0
        })
    end
end

---@param name string
---@param icon string
---@param label string
---@param action function
---@param canInteract function
RegisterPedInteraction = function(name, icon, label, action, canInteract)
    if GetResourceState("ox_target") ~= "missing" then
        local ok, err = pcall(function()
            exports.ox_target:addGlobalPlayer({
                {
                    name = res .. name,
                    icon = icon,
                    label = label,
                    onSelect = function(data)
                        action(data.entity)
                    end,
                    canInteract = function(entity)
                        return canInteract(entity)
                    end,
                    distance = 2.0,
                }
            })
        end)
        if not ok then
            print(("[flake_trunks] ox_target addGlobalPlayer ERROR: %s"):format(err))
        else
            print(("[flake_trunks] ox_target addGlobalPlayer OK: %s"):format(name))
        end
    elseif GetResourceState("qtarget") ~= "missing" then
        exports["qtarget"]:Player({
            options = {
                {
                    name = res .. name,
                    icon = icon,
                    label = label,
                    action = function(data)
                        if type(data) == "table" then
                            action(data.entity)
                        else
                            action(data)
                        end
                    end,
                    canInteract = function(data)
                        if type(data) == "table" then
                            return canInteract(data.entity)
                        else
                            return canInteract(data)
                        end
                    end
                }
            },
            distance = 2.0
        })
    elseif GetResourceState("qb-target") ~= "missing" then
        exports["qb-target"]:AddGlobalPlayer({
            options = {
                {
                    name = res .. name,
                    icon = icon,
                    label = label,
                    action = function(data)
                        if type(data) == "table" then
                            action(data.entity)
                        else
                            action(data)
                        end
                    end,
                    canInteract = function(data)
                        if type(data) == "table" then
                            return canInteract(data.entity)
                        else
                            return canInteract(data)
                        end
                    end
                }
            },
            distance = 2.0
        })
    end
end

---@param label string
---@param duration number
---@param canCancel boolean
---@return boolean
ProgressBar = function(label, duration, canCancel)
    if GetResourceState("ox_lib") ~= "missing" and lib and lib.progressBar then
        return lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = canCancel,
            disable = { move = true, car = true, combat = true },
        })
    end
    return true
end

---@param vehicle number
---@return boolean
IsVehicleNpc = function(vehicle)
    for i = -1, (GetVehicleMaxNumberOfPassengers(vehicle) - 1) do
        if not IsVehicleSeatFree(vehicle, i) then
            local ped = GetPedInVehicleSeat(vehicle, i)
            if DoesEntityExist(ped) then
                if not IsPedAPlayer(ped) then
                    return true
                end
            end
        end
    end

    return false
end

---@param vehicle number
---@return boolean
IsVehicleOpen = function(vehicle)
    return GetVehicleDoorLockStatus(vehicle) == 1
end

---@param vehicle number
---@return boolean
CheckVehicleSpeed = function(vehicle)
    return (GetEntitySpeed(vehicle) * 2.236936) < 15.0 -- its 15 MPH
end

---@param vehicle number
---@return boolean
CanEnterVehicleTrunk = function(vehicle)
    if not InTrunk then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if NetworkDoesNetworkIdExist(netId) then
            local state = Entity(vehicle).state
            if state then
                if state.Trunk == nil then
                    return IsVehicleOpen(vehicle)
                end
            end
        end
    end
    return false
end

---@param vehicle number?
---@return boolean
CanExitVehicleTrunk = function(vehicle)
    local state = LocalPlayer.state
    if InTrunk and not state.SFTRUNKS_DEAD and not state.SFTRUNKS_HANDCUFFED then
        return true
    else
        return false
    end
end

---@param notification string
HudAddNotification = function(notification)
    if GetResourceState("es_extended") ~= "missing" then
        TriggerEvent("esx:showNotification", notification)
    elseif GetResourceState("qb-core") ~= "missing" then
        TriggerEvent("QBCore:Notify", notification)
    else
        ShowNotification("Trunks", notification, "")
    end
end

---@param title string
---@param subtitle string
---@param message string
---@param backgroundColor number?
---@param notifImage string?
---@param iconType number?
---@return number
ShowNotification = function(title, subtitle, message, backgroundColor, notifImage, iconType)
    AddTextEntry("tcpNotification", message)
    BeginTextCommandThefeedPost("tcpNotification")
    if backgroundColor then
        ThefeedSetNextPostBackgroundColor(backgroundColor)
    end
    EndTextCommandThefeedPostMessagetext(notifImage or "CHAR_CASINO", notifImage or "CHAR_CASINO", true, iconType or 4, title, subtitle)
    return EndTextCommandThefeedPostMpticker(false, true)
end

---@param ped number
---@param state boolean
SetPedProofInTrunk = function(ped, state)
    SetEntityProofs(ped, false, false, state, false, false, state, false, false)
end

---@param targetPed number
---@return boolean
CanPutPedInTrunk = function(targetPed)
    local targetIndex = NetworkGetPlayerIndexFromPed(targetPed)
    if targetIndex == -1 then return false end

    local myState = LocalPlayer.state
    if myState.SFTRUNKS_DEAD or myState.SFTRUNKS_HANDCUFFED then return false end

    local targetServerId = GetPlayerServerId(targetIndex)
    local targetState = Player(targetServerId).state

    local isDown = targetState.SFTRUNKS_HANDCUFFED or targetState.SFTRUNKS_DEAD

    if not isDown then
        local wasabiDead = targetState.dead
        isDown = wasabiDead == "dead" or wasabiDead == "laststand"
    end

    return isDown and GetClosestVehicle_T(false, 3.0) ~= nil
end

---@param vehicle number
---@return boolean
CanPullPedFromTrunk = function(vehicle)
    local trunk = Entity(vehicle).state.Trunk
    if trunk ~= nil then
        local targetState = Player(trunk).state
        local wasabiDead = targetState.dead
        local isDown = targetState.SFTRUNKS_DEAD or targetState.SFTRUNKS_HANDCUFFED
                       or wasabiDead == "dead" or wasabiDead == "laststand"
        if not isDown then
            return false
        end
    end
    return not InTrunk and IsVehicleOpen(vehicle) and trunk ~= nil
end

DisableAllControlActions2 = function()
    DisableAllControlActions(0)
end

AddEventHandler("flake_trunks:isUsingCamera", function(state)

end)

AddEventHandler("flake_trunks:inEditor", function(state)

end)

RegisterCommand("trunk_leave", function()
    TriggerEvent("flake_trunks:exitTrunk", TrunkVehicle)
end, false)

Citizen.CreateThread(function()
    RegisterVehicleInteraction("enter_trunk", "fas fa-truck-loading", _L("enterVehicle"), function(vehicle)
        TriggerEvent("flake_trunks:enterTrunk", vehicle)
    end, CanEnterVehicleTrunk)

    RegisterVehicleInteraction("exit_trunk", "fas fa-truck-loading", _L("exitVehicle"), function(vehicle)
        TriggerEvent("flake_trunks:exitTrunk", vehicle)
    end, CanExitVehicleTrunk)

    RegisterPedInteraction("put_player_in_trunk", "fas fa-leaf", _L("putPlayerInTrunk"), function(targetPed)
        TriggerEvent("flake_trunks:putInClosest", targetPed)
    end, CanPutPedInTrunk)

    RegisterVehicleInteraction("pull_player_from_trunk", "fas fa-leaf", _L("pullPlayerFromTrunk"), function(vehicle)
        TriggerEvent("flake_trunks:takeOutPlayer", vehicle)
    end, CanPullPedFromTrunk)
end)

-- ESX
if GetResourceState("es_extended") ~= "missing" then
    RegisterNetEvent("esx_policejob:handcuff", function()
        isHandcuffed = not isHandcuffed
        LocalPlayer.state:set("SFTRUNKS_HANDCUFFED", isHandcuffed, true)
    end)

    RegisterNetEvent("esx_policejob:drag", function(copId)
        if isHandcuffed then
            isDragged = not isDragged
            LocalPlayer.state:set("SFTRUNKS_DRAGGED", isDragged, true)
        end
    end)

    RegisterNetEvent("esx_policejob:putInVehicle", function()
        if isHandcuffed and isDragged then
            Citizen.Wait(100)
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                isDragged = false
                LocalPlayer.state:set("SFTRUNKS_DRAGGED", isDragged, true)
            end
        end
    end)
end

-- QB-CORE
if GetResourceState("qb-core") ~= "missing" then
    RegisterNetEvent("hospital:client:isEscorted", function(dragged)
        isDragged = dragged
        LocalPlayer.state:set("SFTRUNKS_DRAGGED", isDragged, true)
    end)
end

-- wasabi_ambulance: suppress death flag while in trunk so wasabi's repeated
-- laststand updates never corrupt the trunk state bag.
if GetResourceState("wasabi_ambulance") ~= "missing" then
    AddEventHandler("wasabi_ambulance:client:SetDeathStatus", function(isDead)
        if InTrunk then return end
        LocalPlayer.state:set("SFTRUNKS_DEAD", isDead, true)
    end)
end

-- General death monitor — skipped while InTrunk so wasabi's health manipulation
-- during laststand never flickers SFTRUNKS_DEAD and breaks the attachment.
Citizen.CreateThread(function()
    local wasDown = false
    while true do
        if not InTrunk then
            local ped = PlayerPedId()
            local isDown = IsEntityDead(ped) or IsPedFatallyInjured(ped)
            if isDown ~= wasDown then
                wasDown = isDown
                LocalPlayer.state:set("SFTRUNKS_DEAD", isDown, true)
            end
        else
            wasDown = false
        end
        Citizen.Wait(500)
    end
end)

if GetResourceState("wasabi_ambulance") ~= "missing" then
    -- Fired by the server directly at the occupant's client when they are put into
    -- or pulled from a trunk. Wasabi's ClearPedTasks runs in the occupant's Lua
    -- environment so suppression must run there, not on the driver's client.
    RegisterNetEvent("flake_trunks:suppressWasabi")
    AddEventHandler("flake_trunks:suppressWasabi", function(enable)
        if enable then
            exports.wasabi_ambulance:disableKnockoutLoop(true)
            exports.wasabi_ambulance:manuallyKnockout(false)
        else
            exports.wasabi_ambulance:disableKnockoutLoop(false)
        end
    end)

    -- Self-entry suppression: handles voluntary self-entry into a trunk.
    -- The server only fires suppressWasabi for forced put-in by another player.
    Citizen.CreateThread(function()
        local knockoutDisabled = false
        while true do
            if InTrunk and not knockoutDisabled then
                knockoutDisabled = true
                exports.wasabi_ambulance:disableKnockoutLoop(true)
                exports.wasabi_ambulance:manuallyKnockout(false)
            elseif not InTrunk and knockoutDisabled then
                knockoutDisabled = false
                exports.wasabi_ambulance:disableKnockoutLoop(false)
            end
            Citizen.Wait(500)
        end
    end)
end

-- Restore the occupant's visibility when they are pulled out of a trunk.
-- We no longer hide occupants on put-in; the trunk animation + SetEntityInvincible
-- keeps them in position without needing to hide them.
RegisterNetEvent("flake_trunks:setOccupantVisibility")
AddEventHandler("flake_trunks:setOccupantVisibility", function(visible)
    if visible then
        local ped = PlayerPedId()
        SetEntityVisible(ped, true, false)
    end
end)