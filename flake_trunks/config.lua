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
    }
}