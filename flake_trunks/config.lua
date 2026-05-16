Language = "en"

Config = {
    DevMode = false,

    UseProgressBar = true,
    GetIntoTrunkProgressBar = {
        duration = 3000,
        canCancel = true,
    },
    ExitTrunkProgressBar = {
        duration = 2000,
        canCancel = true,
    },
    PutPlayerIntoTrunkProgressBar = {
        duration = 3000,
        canCancel = true,
    },
    GetPlayerOutOfTrunkProgressBar = {
        duration = 2000,
        canCancel = true,
    },
    OffsetEditorKeys = {
        Confirm = { 191, "ENTER" },
        Cancel = { 200, "ESC" },
        OpenAllVehicleDoors = { 22, "SPACE" },
        Position = {
            Forward   = { 32, "W" },
            Backward  = { 31, "S" },
            Left      = { 34, "A" },
            Right     = { 30, "D" },
            Up        = { 45, "R" },
            Down      = { 23, "F" },
        },
        Rotation = {
            XAxis = {
                Minus = { 44, "Q" },
                Plus  = { 38, "E" }
            },
            YAxis = {
                Minus = { 20, "Z" },
                Plus  = { 73, "X" }
            },
            ZAxis = {
                Minus = { 26, "C" },
                Plus  = { 0, "V" }
            }
        }
    },

    Camera = {
        Stationary = false,
        StationaryHeight = 0.2,
        DistanceFromCar = 3.0,
        FreeCameraSpeed = 450.0,
    },

    EnabledKeysWhileInTrunk = {
        249, -- N - INPUT_PUSH_TO_TALK
        245, -- T - INPUT_MP_TEXT_CHAT_ALL
    },

    -- Fallback offsets keyed by GetVehicleClass() result.
    -- Used when a vehicle has no entry in server/offsets.lua.
    -- rz = 180.0 faces the ped toward the rear so the head stays inside the trunk.
    ClassFallbackOffsets = {
        [0]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Compacts
        [1]  = { x = 0.0, y = -2.95, z = 0.25, rz = 180.0 }, -- Sedans
        [2]  = { x = 0.0, y = -3.5,  z = 0.25, rz = 180.0 }, -- SUVs
        [3]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Coupes
        [4]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Muscle
        [5]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Sports Classics
        [6]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Sports
        [7]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Super
        [9]  = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Off-road
        [10] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Industrial
        [11] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Utility
        [12] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Vans
        [17] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Service
        [18] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Emergency
        [19] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Military
        [20] = { x = 0.0, y = -2.85, z = 0.25, rz = 180.0 }, -- Commercial
    }
}