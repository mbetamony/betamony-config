---------------------
---- KEYBINDINGS ----
---------------------

local config = require("lua.config")
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
-- Bayta
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(config.fileManager))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(config.terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(config.menu))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())                    -- close window
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic")) -- scratchpad
hl.bind(mainMod .. " + M", hl.dsp.exit())                            -- log out
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + end", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + end", hl.dsp.exec_cmd("hyprlock & systemctl suspend"))
local directions = {
    h     = "l",
    left  = "l",
    l     = "r",
    right = "r",
    k     = "u",
    up    = "u",
    j     = "d",
    down  = "d"
}

for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Resize the focused window with mainMod + ALT + hjkl/arrows (repeats while held)
local RESIZE_STEP = 40
local resizeDeltas = {
    l = { x = -RESIZE_STEP, y = 0, relative = true },
    r = { x = RESIZE_STEP, y = 0, relative = true },
    u = { x = 0, y = -RESIZE_STEP, relative = true },
    d = { x = 0, y = RESIZE_STEP, relative = true },
}

for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.resize(resizeDeltas[dir]),
        { repeating = true })
end

-- Flip the dwindle split orientation (left/right <-> top/bottom) without
-- changing focus -- handy when SUPER+SHIFT+hjkl alone won't get two windows
-- into the arrangement you want.
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.layout("togglesplit"))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
-- Move the focused window into the scratchpad (toggle it back with mainMod + S)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
