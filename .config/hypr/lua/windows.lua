--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

----------------------------------
---- DESKTOP PROFILES ----
----------------------------------

-- Name each profile's workspace, auto-launch its app(s) the first time it's
-- visited, and keep the app's windows on its home workspace.
-- See lua/profiles.lua to change apps/wallpapers/workspaces.

local profiles = require("lua.profiles")

for _, p in ipairs(profiles.profiles) do
    hl.workspace_rule({
        workspace         = tostring(p.id),
        default_name      = p.label,
        on_created_empty  = "exec " .. p.exec,
    })

    hl.window_rule({
        name      = "profile-" .. p.name,
        match     = { class = p.class },
        workspace = tostring(p.id),
    })
end
