-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- NOTE: this only runs on a full compositor start (login), not on
-- `hyprctl reload` -- log out/in to pick up changes here.

hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("/usr/libexec/hyprpolkitagent")
    hl.exec_cmd("wl-paste --watch cliphist store")
end)
