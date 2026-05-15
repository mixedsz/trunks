local function isNetIdValid(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    return entity and entity ~= 0
end

-- Send trunk offsets to a connecting client
RegisterNetEvent("flake_trunks:init", function()
    local src = source
    TriggerClientEvent("flake_trunks:getOffsets", src, Offsets)
end)

-- Update vehicle and player state bags when a player enters or exits a trunk
RegisterNetEvent("flake_trunks:inTrunk", function(vehicleNetId, inTrunk)
    local src = source

    if not isNetIdValid(vehicleNetId) then return end
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if inTrunk then
        Entity(vehicle).state:set("Trunk", src, true)
        Player(src).state:set("InTrunk", vehicleNetId, true)
    else
        local currentOccupant = Entity(vehicle).state.Trunk
        if currentOccupant == src then
            Entity(vehicle).state:set("Trunk", nil, true)
        end
        Player(src).state:set("InTrunk", nil, true)
    end
end)

-- Force a target player (must be dead or handcuffed) into the closest vehicle's trunk
RegisterNetEvent("flake_trunks:putInClosest", function(targetServerId, vehicleNetId)
    local src = source

    if not isNetIdValid(vehicleNetId) then return end

    local targetState = Player(targetServerId).state
    local wasabiDead = targetState.dead
    local isDown = targetState.SFTRUNKS_DEAD or targetState.SFTRUNKS_HANDCUFFED
                   or wasabiDead == "dead" or wasabiDead == "laststand"
    if not isDown then return end

    -- Put the player in the trunk
    TriggerClientEvent("flake_trunks:getIn", targetServerId, vehicleNetId)

    -- Stop wasabi's knockout loop on the occupant's client so it stops calling
    -- ClearPedTasks which was killing the trunk animation every ~300ms.
    TriggerClientEvent("flake_trunks:suppressWasabi", targetServerId, true)

    -- Make the occupant invisible on their own client to fully hide any residual
    -- wasabi death animation that fights the trunk attachment.
    TriggerClientEvent("flake_trunks:setOccupantVisibility", targetServerId, false)
end)

-- Pull the player currently occupying a vehicle's trunk out of it
RegisterNetEvent("flake_trunks:takeOutPlayer", function(vehicleNetId)
    local src = source

    if not isNetIdValid(vehicleNetId) then return end
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    local occupant = Entity(vehicle).state.Trunk
    if occupant ~= nil then
        -- Make the occupant visible again as the progress bar starts playing
        -- on the puller's screen — they'll see the player appear as they're pulled out.
        TriggerClientEvent("flake_trunks:setOccupantVisibility", occupant, true)

        -- Re-enable wasabi's knockout loop now that they're leaving the trunk.
        TriggerClientEvent("flake_trunks:suppressWasabi", occupant, false)

        -- Pull them out
        TriggerClientEvent("flake_trunks:getOut", occupant, vehicleNetId)
    end
end)

-- Save a newly calibrated trunk offset (dev mode only) and broadcast to all clients
RegisterNetEvent("flake_trunks:saveConfig", function(model, posVec, rotVec)
    local src = source

    if not Config.DevMode then return end

    Offsets[model] = {
        o = { x = posVec.x, y = posVec.y, z = posVec.z },
        r = { x = rotVec.x, y = rotVec.y, z = rotVec.z },
    }

    TriggerClientEvent("flake_trunks:setNewOffset", -1, model, Offsets[model].o, Offsets[model].r)

    print(("[flake_trunks] Saved offset for model %s: o(%.3f, %.3f, %.3f) r(%.3f, %.3f, %.3f)"):format(
        model,
        posVec.x, posVec.y, posVec.z,
        rotVec.x, rotVec.y, rotVec.z
    ))
end)