-- Send trunk offsets to a connecting client
RegisterNetEvent("sf-trunks:init", function()
    local src = source
    TriggerClientEvent("sf-trunks:getOffsets", src, Offsets)
end)

-- Update vehicle and player state bags when a player enters or exits a trunk
RegisterNetEvent("sf-trunks:inTrunk", function(vehicleNetId, inTrunk)
    local src = source

    if not NetworkDoesNetworkIdExist(vehicleNetId) then return end
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    if inTrunk then
        Entity(vehicle).state:set("Trunk", src, true)
        Player(src).state:set("InTrunk", vehicleNetId, true)
    else
        -- Only clear the vehicle's Trunk bag if this player is actually the one in it
        local currentOccupant = Entity(vehicle).state.Trunk
        if currentOccupant == src then
            Entity(vehicle).state:set("Trunk", nil, true)
        end
        Player(src).state:set("InTrunk", nil, true)
    end
end)

-- Force a target player (must be dead or handcuffed) into the closest vehicle's trunk
RegisterNetEvent("sf-trunks:putInClosest", function(targetServerId, vehicleNetId)
    local src = source

    if not NetworkDoesNetworkIdExist(vehicleNetId) then return end

    local targetState = Player(targetServerId).state
    if not targetState.SFTRUNKS_DEAD and not targetState.SFTRUNKS_HANDCUFFED then
        return
    end

    TriggerClientEvent("sf-trunks:getIn", targetServerId, vehicleNetId)
end)

-- Pull the player currently occupying a vehicle's trunk out of it
RegisterNetEvent("sf-trunks:takeOutPlayer", function(vehicleNetId)
    local src = source

    if not NetworkDoesNetworkIdExist(vehicleNetId) then return end
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)

    local occupant = Entity(vehicle).state.Trunk
    if occupant ~= nil then
        TriggerClientEvent("sf-trunks:getOut", occupant, vehicleNetId)
    end
end)

-- Save a newly calibrated trunk offset (dev mode only) and broadcast to all clients
RegisterNetEvent("sf-trunks:saveConfig", function(model, posVec, rotVec)
    local src = source

    if not Config.DevMode then return end

    Offsets[model] = {
        o = { x = posVec.x, y = posVec.y, z = posVec.z },
        r = { x = rotVec.x, y = rotVec.y, z = rotVec.z },
    }

    TriggerClientEvent("sf-trunks:setNewOffset", -1, model, Offsets[model].o, Offsets[model].r)

    print(("[sf-trunks] Saved offset for model %s: o(%.3f, %.3f, %.3f) r(%.3f, %.3f, %.3f)"):format(
        model,
        posVec.x, posVec.y, posVec.z,
        rotVec.x, rotVec.y, rotVec.z
    ))
end)
