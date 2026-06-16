-----------------------
---- WALLPAPERS ----
-----------------------

-- Starts swww (the wallpaper daemon) and switches the wallpaper to match
-- the active workspace's desktop profile (see lua/profiles.lua).
-- Drop your own images into ~/Pictures/Wallpapers/<name>.png to override
-- the generated defaults.

local profiles = require("lua.profiles")

local function wallpaper_for(ws_id)
    for _, p in ipairs(profiles.profiles) do
        if ws_id == p.id then return p.wallpaper end
    end
    return profiles.default_wallpaper
end

local function set_wallpaper(path)
    hl.exec_cmd(string.format(
        "swww img '%s' --transition-type=fade --transition-duration=0.5", path))
end

hl.on("hyprland.start", function()
    hl.exec_cmd("swww-daemon")
    -- Give swww-daemon a moment to come up before the first `swww img` call.
    hl.timer(function()
        set_wallpaper(wallpaper_for(1))
    end, { timeout = 500, type = "oneshot" })
end)

hl.on("workspace.active", function()
    local ws = hl.get_active_workspace()
    if ws then set_wallpaper(wallpaper_for(ws.id)) end
end)
