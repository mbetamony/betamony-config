local M = {}

M.terminal = "ghostty"
M.fileManager = "nautilus"
M.menu = "wofi --show drun"

-- App commands used by desktop profiles (lua/profiles.lua) and keybindings.
-- Change an app here and it updates everywhere it's referenced.
M.browser = os.getenv("HOME") .. "/Applications/helium.AppImage"
M.editor = "zed"
M.chat = "flatpak run com.discordapp.Discord"
M.media = "env DESKTOPINTEGRATION=1 " .. os.getenv("HOME") .. "/AppImages/cider.appimage"
M.gaming = "steam"
M.gamingLauncher = "flatpak run com.heroicgameslauncher.hgl"
M.streaming = "flatpak run com.obsproject.Studio"

return M
