# Hyprland shortcuts & setup

`SUPER` = the Windows/Cmd key (bottom row, 2nd from the left).

## Vim-style navigation

If you know vim's `h j k l` (left, down, up, right), the same letters work
throughout this config — arrow keys do the same thing, so use whichever you
like:

| Modifier              | Action on `h / j / k / l` (or arrows)      |
|-----------------------|---------------------------------------------|
| `SUPER`               | Move **focus** left / down / up / right      |
| `SUPER + SHIFT`       | **Move** the focused window in that direction |
| `SUPER + ALT`         | **Resize** the focused window (shrink/grow width or height), repeats while held |

Resize step is 40px per tick — change `RESIZE_STEP` in `lua/keybindings.lua`
to taste.

---

## Full keybind reference

### Window focus / move / resize

| Keys | Action |
|---|---|
| `SUPER` + `h/j/k/l` or arrows | Move focus left/down/up/right |
| `SUPER + SHIFT` + `h/j/k/l` or arrows | Move focused window left/down/up/right |
| `SUPER + ALT` + `h/j/k/l` or arrows | Resize focused window (hold to repeat) |
| `SUPER + V` | Toggle floating |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + Q` | Close focused window |
| `SUPER` + drag with left mouse button | Move window |
| `SUPER` + drag with right mouse button | Resize window |

### Workspaces

| Keys | Action |
|---|---|
| `SUPER + 1` .. `SUPER + 0` | Switch to workspace 1-10 |
| `SUPER + SHIFT + 1` .. `SUPER + SHIFT + 0` | Move focused window to workspace 1-10 |
| `SUPER` + scroll wheel | Cycle through existing workspaces |

### Apps & launchers

| Keys | Action |
|---|---|
| `SUPER + Return` | Open terminal (Ghostty) |
| `SUPER + E` | Open file manager (Nautilus) |
| `SUPER + R` | App launcher (wofi) |
| `SUPER + P` | Screenshot a region (hyprshot) |

### Scratchpads

| Keys | Action |
|---|---|
| `SUPER + S` | Toggle the general scratchpad (`special:magic`) |
| `SUPER + SHIFT + S` | Move the focused window into the general scratchpad |
| `` SUPER + ` `` (grave/backtick) | Toggle a dropdown terminal ("quickterm") |

The dropdown terminal is a Quake-style scratchpad: the first press spawns a
floating Ghostty window (class `quickterm`) centered at 70% screen size on
its own special workspace; every press after that just shows/hides it.

### System

| Keys | Action |
|---|---|
| `SUPER + End` | Lock the screen |
| `SUPER + SHIFT + End` | Lock and suspend |
| `SUPER + M` | Log out |

### Media keys

| Key | Action |
|---|---|
| Volume Up / Down / Mute | Adjust / mute audio output |
| Mic Mute | Toggle microphone mute |
| Brightness Up / Down | Adjust screen brightness |
| Play/Pause, Next, Previous | Media player control (via `playerctl`) |

---

## Desktop profiles

Workspaces 1-6 are "profiles": each one auto-launches its app(s) the first
time you switch to it, keeps that app's windows on that workspace, and sets
its own wallpaper.

| Workspace | Profile | App(s) | Wallpaper |
|---|---|---|---|
| 1 | Browser | Helium | `browser.png` |
| 2 | Code | Zed + Ghostty | `code.png` |
| 3 | Chat | Discord | `chat.png` |
| 4 | Media | Cider | `media.png` |
| 5 | Gaming | Steam + Heroic | `gaming.png` |
| 6 | Streaming | OBS Studio | `streaming.png` |
| 7-10 | (free) | — | `default.png` |

### How it works

- `lua/config.lua` holds the **app command** for each role (`M.browser`,
  `M.editor`, `M.chat`, ...).
- `lua/profiles.lua` maps each profile to a workspace number, the wallpaper
  file, and a window-class regex used to keep that app's windows on its home
  workspace.
- `lua/windows.lua` turns that table into Hyprland workspace/window rules:
  the first time you visit workspace N, its app(s) launch automatically
  (`on_created_empty`).
- `lua/wallpapers.lua` runs `swww` and switches the wallpaper whenever the
  active workspace changes.

### Customizing

- **Swap an app** (e.g. browser): edit its command in `lua/config.lua` —
  one line, picked up everywhere it's referenced.
- **Change a profile's workspace number, wallpaper file, or window-matching**:
  edit the relevant entry in `lua/profiles.lua`.
- **Replace a wallpaper**: drop an image at `~/Pictures/Wallpapers/<name>.png`
  (any resolution — swww scales/crops). The generated ones are simple
  gradients; swap them for real images anytime.
- **An app doesn't land on its home workspace**: open it, run
  `hyprctl clients -j | grep -i class` to find its real window class, and
  update the `class` field for that profile in `lua/profiles.lua`.

---

## Idle behavior

Configured in `hypridle.conf`:

- After **10 minutes** idle: the screen locks (`hyprlock`).
- ~30 seconds later (10.5 min total): the display turns off (DPMS), and
  turns back on at the next input.
- No auto-suspend — suspend manually with `SUPER + SHIFT + End`.

To change the timeouts, edit the `timeout` values (in seconds) in
`hypridle.conf`. **hypridle is started at login** (via `lua/autostart.lua`),
so changes here need a logout/login (or reboot) to take effect — a plain
`hyprctl reload` isn't enough.

---

## macOS setup

`macos/aerospace.toml` is a config for [AeroSpace](https://github.com/nikitabobko/AeroSpace),
an i3-style tiling window manager for macOS, with the same `h/j/k/l` +
workspace layout as this config — so muscle memory carries over without
remapping anything in Karabiner.

**Install** (on the Mac): `brew install --cask nikitabobko/tap/aerospace`,
then copy `macos/aerospace.toml` to `~/.config/aerospace/aerospace.toml`.

### Key mapping

macOS's `Option (⌥)` key sits in the same physical position as the PC's
`Windows/Super` key (2nd from the left, bottom row), so AeroSpace uses
`alt` as its main modifier — same finger, same muscle memory:

| Hyprland (PC) | AeroSpace (Mac) |
|---|---|
| `SUPER` | `alt` (Option ⌥) |
| `SUPER + SHIFT` | `alt-shift` |
| `SUPER + ALT` (resize) | `alt-cmd` (Cmd occupies the PC's `ALT` position) |

So `alt-h/j/k/l` = focus, `alt-shift-h/j/k/l` = move window,
`alt-cmd-h/j/k/l` = resize, `alt-1`..`alt-6` = the same six profile
workspaces (Browser/Code/Chat/Media/Gaming/Streaming), `alt-enter` =
terminal, `alt-q` = close window, `alt-f` = fullscreen, `alt-v` = float.

To auto-assign Mac apps to workspaces (like the desktop profiles above), add
`[[on-window-detected]]` rules — see the commented examples in
`macos/aerospace.toml`, and find an app's id with `aerospace list-apps`.
