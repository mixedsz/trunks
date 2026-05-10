local resourceName = GetCurrentResourceName()
local currentVersion = GetResourceMetadata(resourceName, "version", 0)

CreateThread(function()
    PerformHttpRequest("https://api.github.com/repos/mmleczek/sf-trunks/releases/latest", function(statusCode, body, headers)
        if statusCode ~= 200 then return end

        local ok, data = pcall(json.decode, body)
        if not ok or not data or not data.tag_name then return end

        local latestVersion = data.tag_name:gsub("^v", "")

        if latestVersion ~= currentVersion then
            print(("[sf-trunks] ^3A newer version is available: %s (current: %s)^0"):format(latestVersion, currentVersion))
            print("[sf-trunks] ^3Visit https://store.scriptforge.gg to update.^0")
        else
            print(("[sf-trunks] ^2Running latest version: %s^0"):format(currentVersion))
        end
    end, "GET", "", { ["User-Agent"] = "FiveM-Resource-Version-Check" })
end)
