----------------------
---- DESKTOP PROFILES ----
----------------------

-- Each profile is a workspace that auto-launches its app(s) the first time
-- you switch to it (see lua/windows.lua) and sets its own wallpaper
-- (see lua/wallpapers.lua).
--
-- To change WHICH app is used: edit the matching field in lua/config.lua.
-- To change the WORKSPACE NUMBER, WALLPAPER, or WINDOW-MATCHING for a
-- profile, edit the table below. To find an app's window class, open it and
-- run: hyprctl clients -j | grep -i class

local config = require("lua.config")

local M = {}
M.wallpaper_dir = os.getenv("HOME") .. "/Pictures/Wallpapers"
M.default_wallpaper = M.wallpaper_dir .. "/default.png"

M.profiles = {
    { id = 1, name = "browser",   label = "Browser",
      exec = config.browser,
      class = "^helium$",
      wallpaper = M.wallpaper_dir .. "/browser.png" },

    { id = 2, name = "code",      label = "Code",
      exec = config.editor .. "; " .. config.terminal,
      class = "^(dev\\.zed\\.Zed|com\\.mitchellh\\.ghostty)$",
      wallpaper = M.wallpaper_dir .. "/code.png" },

    { id = 3, name = "chat",      label = "Chat",
      exec = config.chat,
      class = "^(discord|com\\.discordapp\\.Discord)$",
      wallpaper = M.wallpaper_dir .. "/chat.png" },

    { id = 4, name = "media",     label = "Media",
      exec = config.media,
      class = "^[Cc]ider$",
      wallpaper = M.wallpaper_dir .. "/media.png" },

    { id = 5, name = "gaming",    label = "Gaming",
      exec = config.gaming .. "; " .. config.gamingLauncher,
      class = "^(steam|steam_app_.*|com\\.heroicgameslauncher\\.hgl)$",
      wallpaper = M.wallpaper_dir .. "/gaming.png" },

    { id = 6, name = "streaming", label = "Streaming",
      exec = config.streaming,
      class = "^com\\.obsproject\\.Studio$",
      wallpaper = M.wallpaper_dir .. "/streaming.png" },
}

return M
