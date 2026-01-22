{ config, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    settings = {
      "monitor" = "eDP-1,1920x1080@60,0x0,1.25";

      general = {
        "gaps_in" = 5;
        "gaps_out" = 10;
        "border_size" = 0;
        "col.active_border" = "rgba(707070ff)";
        "col.inactive_border" = "rgba(d0d0d0ff)";
        "layout" = "dwindle";
      };

      decoration = {
        "rounding" = 12;
        "active_opacity" = 1.0;
        "inactive_opacity" = 0.9;
        shadow = {
          enabled = true;
          "range" = 30;
          "render_power" = 5;
          "offset" = "0 5";
          "color" = "rgba(00000070)";
        };
        blur = {
          enabled = true;
          "size" = 3;
          "passes" = 1;
          "vibrancy" = 0.1696;
        };
      };

      animations = {
        enabled = "no";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        "pseudotile" = true;
        "preserve_split" = true;
      };

      master = {
        "new_status" = "master";
      };

      misc = {
        "force_default_wallpaper" = -1;
        "disable_hyprland_logo" = true;
        "disable_splash_rendering" = true;
      };

      input = {
        "kb_layout" = "fr,us";
        "kb_variant" = ",";
        "kb_options" = "grp:alt_shift_toggle";

        "follow_mouse" = 1;

        "sensitivity" = 0;

        touchpad = {
          "natural_scroll" = true;
        };

        "repeat_rate" = 40;
        "repeat_delay" = 300;
      };

      gesture = "3, horizontal, workspace";

      device = {
        "name" = "epic-mouse-v1";
        "sensitivity" = -0.5;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, T, exec, uwsm app -- kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exec, uwsm stop"
        "$mainMod, E, exec, uwsm app -- thunar"
        "$mainMod, F, togglefloating,"
        "$mainMod, R, exec, dms ipc call spotlight toggle"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, L, exec, dms ipc call lock lock"
        "$mainMod, V, exec, dms ipc call clipboard toggle"
        "$mainMod, N, exec, dms ipc call notifications toggle"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, ampersand, workspace, 1"
        "$mainMod, eacute, workspace, 2"
        "$mainMod, quotedbl, workspace, 3"
        "$mainMod, apostrophe, workspace, 4"
        "$mainMod, parenleft, workspace, 5"
        "$mainMod, egrave, workspace, 6"
        "$mainMod, minus, workspace, 7"
        "$mainMod, underscore, workspace, 8"
        "$mainMod, ccedilla, workspace, 9"
        "$mainMod, agrave, workspace, 10"

        "$mainMod SHIFT, ampersand, movetoworkspace, 1"
        "$mainMod SHIFT, eacute, movetoworkspace, 2"
        "$mainMod SHIFT, quotedbl, movetoworkspace, 3"
        "$mainMod SHIFT, apostrophe, movetoworkspace, 4"
        "$mainMod SHIFT, parenleft, movetoworkspace, 5"
        "$mainMod SHIFT, egrave, movetoworkspace, 6"
        "$mainMod SHIFT, minus, movetoworkspace, 7"
        "$mainMod SHIFT, underscore, movetoworkspace, 8"
        "$mainMod SHIFT, ccedilla, movetoworkspace, 9"
        "$mainMod SHIFT, agrave, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, PRINT, exec, dms screenshot -d ${config.home.homeDirectory}/Pictures/Screenshots"
        "$mainMod, F11, fullscreen"
        "$mainMod, Tab, exec, dms ipc call hypr toggleOverview"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, dms ipc call audio increment 3"
        ",XF86AudioLowerVolume, exec, dms ipc call audio decrement 3"
        ",XF86AudioMute, exec, dms ipc call audio mute"
        ",XF86AudioMicMute, exec, dms ipc call audio micmute"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      xwayland = {
        "force_zero_scaling" = true;
      };

      windowrule = [
        "match:float 0, match:focus 0, opacity 0.9 0.9"
        "match:class ^(org\.gnome\.), rounding 12"
        "match:class ^(org\.gnome\.), border_size 0"
        "match:class ^(kitty)$, border_size 0"
        "match:class ^(gnome-calculator)$, float on"
        "match:class ^(blueman-manager)$, float on"
        "match:class ^(org\.gnome\.Nautilus)$, float on"
        "match:class ^(org.quickshell)$, float on"
      ];
    };
  };
}