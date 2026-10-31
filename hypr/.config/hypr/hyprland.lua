-- Native Hyprland Lua config for Hyprland 0.56.2
-- Converted from your original hyprland.conf

local home = os.getenv("HOME")
local config_dir = home .. "/.config/hypr"
local screenshots = home .. "/Pictures/Screenshots"
local mainMod = "SUPER"

-- Monitor
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- Environment
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- Input, appearance and layout
hl.config({
    input = {
        kb_layout = "us,rs",
        kb_variant = ",latin",
        kb_model = "",
        kb_rules = "",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
            disable_while_typing = false,
            clickfinger_behavior = true,
        },
    },

    general = {
        gaps_in = 2,
        gaps_out = 10,
        border_size = 2,

        col = {
            active_border = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 5,

        blur = {
            enabled = true,
            size = 1,
            passes = 2,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
    },
})

-- Animations
hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.05 },
    },
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default",
})

-- Startup applications
hl.on("hyprland.start", function()
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("kdeconnectd")
    hl.exec_cmd(config_dir .. "/xdg-portal-hyprland")

    hl.exec_cmd(
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    )

    hl.exec_cmd(
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    )

    hl.exec_cmd(
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    )

    hl.exec_cmd("waybar & hypridle")

    hl.exec_cmd(
        --"swaybg -m fill -i " .. config_dir .. "/hong-kong-night.jpg"
        "pcmanfm-qt --desktop"
    )
    --hl.exec_cmd([[sh -c 'systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_RUNTIME_DIR DISPLAY && systemctl --user restart zenscreen']])
    hl.exec_cmd([[sh -c 'sleep 3; "$HOME/Downloads/activitywatch-tauri-0.14.1-linux-x86_64.AppImage"']])
end)

-- Application keybindings
hl.bind(mainMod .. " + Q",
    hl.dsp.exec_cmd("kitty"))

hl.bind(mainMod .. " + SHIFT + X",
    hl.dsp.window.close())

hl.bind(mainMod .. " + L",
    hl.dsp.exec_cmd("swaylock"))

hl.bind(mainMod .. " + M",
    hl.dsp.exec_cmd("wlogout --protocol layer-shell"))

hl.bind(mainMod .. " + SHIFT + M",
    hl.dsp.exit())

hl.bind(mainMod .. " + E",
    hl.dsp.exec_cmd("dolphin"))

hl.bind(mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + A",
    hl.dsp.exec_cmd("rofi -show drun"))

hl.bind(mainMod .. " + P",
    hl.dsp.window.pseudo())

hl.bind(mainMod .. " + S",
    hl.dsp.exec_cmd(
        "hyprshot -m output -o " .. screenshots .. " -c"
    ))

hl.bind(mainMod .. " + B",
    hl.dsp.exec_cmd("firefox"))

hl.bind(mainMod .. " + W",
    hl.dsp.exec_cmd("pkill waybar || waybar"))

-- Multimedia and laptop-specific keys from original config
hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))

hl.bind("code:122",
    hl.dsp.exec_cmd("swayosd-client --output-volume lower"))

hl.bind("code:123",
    hl.dsp.exec_cmd("swayosd-client --output-volume raise"))

hl.bind("code:256",
    hl.dsp.exec_cmd("pamixer --default-source -t"))

hl.bind("code:232",
    hl.dsp.exec_cmd("swayosd-client --brightness lower"))

hl.bind("code:233",
    hl.dsp.exec_cmd("swayosd-client --brightness raise"))

hl.bind("code:210",
    hl.dsp.exec_cmd("asusctl led-mode -n"))

-- Focus movement
hl.bind(mainMod .. " + left",
    hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + right",
    hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + up",
    hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + down",
    hl.dsp.focus({ direction = "down" }))

-- Switch workspaces and move windows to workspaces
for i = 1, 10 do
    local key = tostring(i % 10)

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" }))

-- Move and resize windows with SUPER + mouse
hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- Media controls
hl.bind(mainMod .. " + ALT + SPACE",
    hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind(mainMod .. " + ALT + N",
    hl.dsp.exec_cmd("playerctl next"))

hl.bind(mainMod .. " + ALT + P",
    hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioStop",
    hl.dsp.exec_cmd("playerctl stop"))

hl.bind(mainMod .. " + Print",
    hl.dsp.exec_cmd(
        "hyprshot -m active -o " .. screenshots .. " -z --clipboard-only"
    ))
