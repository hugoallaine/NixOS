{ config, lib, ... }:
let
  mkBezier = name: p1: p2: {
    _args = [
      name
      {
        type = "bezier";
        points = [ p1 p2 ];
      }
    ];
  };

  mkAnim = leaf: speed: curve: style:
    {
      inherit leaf speed;
      enabled = true;
      bezier = curve;
    }
    // lib.optionalAttrs (style != null) { inherit style; };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    configType = "lua";

    # Chaque attribut devient un appel hl.<nom>(...) ; une liste = un appel par élément.
    settings = {
      monitor = {
        output = "eDP-1";
        mode = "1920x1080@60";
        position = "0x0";
        scale = "1.25";
      };

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 0;
          col = {
            active_border = "rgba(707070ff)";
            inactive_border = "rgba(d0d0d0ff)";
          };
          layout = "dwindle";
        };

        decoration = {
          rounding = 12;
          active_opacity = 1.0;
          inactive_opacity = 0.9;
          shadow = {
            enabled = true;
            range = 30;
            render_power = 4;
            offset = [ 0 5 ];
            color = "rgba(00000070)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations.enabled = false;

        # "pseudotile" n'existe plus dans Hyprland 0.55 : retiré.
        dwindle.preserve_split = true;

        master.new_status = "master";

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        input = {
          kb_layout = "fr,us";
          kb_variant = ",";
          kb_options = "grp:alt_shift_toggle";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad.natural_scroll = true;
          repeat_rate = 40;
          repeat_delay = 300;
        };

        xwayland.force_zero_scaling = true;
      };

      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # "curve" est dans importantPrefixes : rendu avant "animation".
      curve = [
        (mkBezier "easeOutQuint" [ 0.23 1 ] [ 0.32 1 ])
        (mkBezier "easeInOutCubic" [ 0.65 0.05 ] [ 0.36 1 ])
        (mkBezier "linear" [ 0 0 ] [ 1 1 ])
        (mkBezier "almostLinear" [ 0.5 0.5 ] [ 0.75 1.0 ])
        (mkBezier "quick" [ 0.15 0 ] [ 0.1 1 ])
      ];

      animation = [
        (mkAnim "global" 10 "default" null)
        (mkAnim "border" 5.39 "easeOutQuint" null)
        (mkAnim "windows" 4.79 "easeOutQuint" null)
        (mkAnim "windowsIn" 4.1 "easeOutQuint" "popin 87%")
        (mkAnim "windowsOut" 1.49 "linear" "popin 87%")
        (mkAnim "fadeIn" 1.73 "almostLinear" null)
        (mkAnim "fadeOut" 1.46 "almostLinear" null)
        (mkAnim "fade" 3.03 "quick" null)
        (mkAnim "layers" 3.81 "easeOutQuint" null)
        (mkAnim "layersIn" 4 "easeOutQuint" "fade")
        (mkAnim "layersOut" 1.5 "linear" "fade")
        (mkAnim "fadeLayersIn" 1.79 "almostLinear" null)
        (mkAnim "fadeLayersOut" 1.39 "almostLinear" null)
        (mkAnim "workspaces" 1.94 "almostLinear" "fade")
        (mkAnim "workspacesIn" 1.21 "almostLinear" "fade")
        (mkAnim "workspacesOut" 1.94 "almostLinear" "fade")
      ];

      window_rule = [
        {
          name = "dim-unfocused-tiled";
          match = {
            float = false;
            focus = false;
          };
          opacity = "0.9 0.9";
        }
        {
          name = "gnome-apps";
          match.class = "^(org\\.gnome\\.)";
          rounding = 12;
          border_size = 0;
        }
        {
          name = "kitty";
          match.class = "^(kitty)$";
          border_size = 0;
        }
        {
          name = "floating-apps";
          match.class = "^(gnome-calculator|blueman-manager|org\\.gnome\\.Nautilus|org\\.quickshell)$";
          float = true;
        }
      ];
    };

    # Binds en Lua brut : plus lisible que des mkLuaInline, et permet la boucle des workspaces.
    extraConfig = ''
      local mainMod = "SUPER"
      local function key(k) return mainMod .. " + " .. k end

      hl.bind(key("T"), hl.dsp.exec_cmd("uwsm app -- kitty"))
      hl.bind(key("C"), hl.dsp.window.close())
      hl.bind(key("M"), hl.dsp.exec_cmd("uwsm stop"))
      hl.bind(key("E"), hl.dsp.exec_cmd("uwsm app -- thunar"))
      hl.bind(key("F"), hl.dsp.window.float({ action = "toggle" }))
      hl.bind(key("R"), hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
      hl.bind(key("P"), hl.dsp.window.pseudo())
      hl.bind(key("J"), hl.dsp.layout("togglesplit"))
      hl.bind(key("L"), hl.dsp.exec_cmd("dms ipc call lock lock"))
      hl.bind(key("V"), hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
      hl.bind(key("N"), hl.dsp.exec_cmd("dms ipc call notifications toggle"))

      hl.bind(key("left"),  hl.dsp.focus({ direction = "left" }))
      hl.bind(key("right"), hl.dsp.focus({ direction = "right" }))
      hl.bind(key("up"),    hl.dsp.focus({ direction = "up" }))
      hl.bind(key("down"),  hl.dsp.focus({ direction = "down" }))

      -- Rangée des chiffres AZERTY (sans Shift)
      local wsKeys = {
        "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft",
        "egrave", "minus", "underscore", "ccedilla", "agrave",
      }
      for i, k in ipairs(wsKeys) do
        hl.bind(key(k),              hl.dsp.focus({ workspace = i }))
        hl.bind(key("SHIFT + " .. k), hl.dsp.window.move({ workspace = i }))
      end

      hl.bind(key("S"),         hl.dsp.workspace.toggle_special("magic"))
      hl.bind(key("SHIFT + S"), hl.dsp.window.move({ workspace = "special:magic" }))

      hl.bind(key("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(key("mouse_up"),   hl.dsp.focus({ workspace = "e-1" }))

      hl.bind(key("PRINT"), hl.dsp.exec_cmd("dms screenshot -d ${config.home.homeDirectory}/Pictures/Screenshots"))
      hl.bind(key("F11"),   hl.dsp.window.fullscreen())
      hl.bind(key("Tab"),   hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))

      -- ex-bindm
      hl.bind(key("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
      hl.bind(key("mouse:273"), hl.dsp.window.resize(), { mouse = true })

      -- ex-bindel (locked + repeating)
      local el = { locked = true, repeating = true }
      hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("dms ipc call audio increment 3"), el)
      hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("dms ipc call audio decrement 3"), el)
      hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("dms ipc call audio mute"), el)
      hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("dms ipc call audio micmute"), el)
      hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), el)
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), el)

      -- ex-bindl (locked)
      local l = { locked = true }
      hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), l)
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), l)
      hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), l)
      hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), l)
    '';
  };
}
