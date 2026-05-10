fx_version   "cerulean"
lua54        "yes"
game         "gta5"
name         "sf-trunks"
author       "mmleczek (scriptforge.gg)"
version      "1.0.3"
description  "Script to hide in vehicle's trunk for FiveM"
ui_page "html/index.html"
dependencies {
	"/server:5848",
    "/onesync",
    "ox_target",
    "ox_lib",
}
files {
    "html/**/*"
}
shared_scripts {
    "@ox_lib/init.lua",
    "config.lua",
    "modules/shared_*.lua",
    "locales/*.lua",
}
client_scripts {
    "client/editable_client.lua",
    "client/main.lua",
}
server_scripts {
    "modules/server_version.lua",
    "server/offsets.lua",
    "server/main.lua"
}
escrow_ignore {
    "config.lua",
    "client/editable_client.lua",
    "locales/*.lua",
    "modules/*.lua",
    "server/*.lua",
}
dependency '/assetpacks'
