# hallaine's home-manager configuration
{
  config,
  pkgs,
  pkgs-unstable,
  walker,
  ...
}:

#${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine --screen-root eDP-1 1216525525 &
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init
    ${pkgs.swww}/bin/swww img /home/hallaine/wallpaper/landscape.jpg
    ${pkgs.dunst}/bin/dunst &
    exec systemctl --user start hyprpolkitagent
  '';
in
{
  imports = [walker.homeManagerModules.default];

  home.username = "hallaine";
  home.homeDirectory = "/home/hallaine";

  home.sessionVariables = {
    EDITOR = "nano";
    TERM = "xterm";
    XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
    XDG_VIDEOS_DIR = "${config.home.homeDirectory}/Videos";
    XDG_MUSIC_DIR = "${config.home.homeDirectory}/Musics";
    XDG_DOWNLOAD_DIR = "${config.home.homeDirectory}/Downloads";
    HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
  };
  home.sessionPath = [
    "$HOME/.config/waybar/scripts"
  ];

  home.packages =
    with pkgs;
    let

    in
    [
      # CLI Tools
      nixfmt-rfc-style
      btop
      zoxide
      mcfly
      git
      brightnessctl
      playerctl
      screen
      fastfetch
      unzip
      kubectl
      kubernetes-helm

      # Hyprland
      swww
      linux-wallpaperengine
      rofi-wayland
      dunst
      libnotify
      networkmanagerapplet
      blueman
      pavucontrol
      hyprshot
      hyprpicker
      hyprpolkitagent
      pkgs-unstable.hyprsysteminfo
      kdePackages.dolphin
      kdePackages.qtsvg
      galculator

      # Keyring
      gcr
      seahorse

      # Web Browser
      brave

      # Editing
      onlyoffice-desktopeditors

      # Media player
      plexamp
      vlc
      spotify

      # Pictures editor
      gimp

      # Communications
      discord
      element-desktop

      # Games
      solitaire-tui
      melonDS

      # Server Management
      ipmiview

      # UTBM
      ciscoPacketTracer8
    ];

  programs.git = {
    enable = true;
    userName = "hugoallaine";
    userEmail = "hugo+github@allaine.cc";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      eval "$(zoxide init bash)"
      eval "$(mcfly init bash)"
      export MCFLY_RESULTS=50
      export MCFLY_RESULTS_SORT=LAST_RUN
    '';
    shellAliases = {
      cd = "z";
      cdi = "zi";
      nos = "sudo nixos-rebuild switch --flake ~/repo/nixos/#laptop-nixos-allaine-cc";
      not = "sudo nixos-rebuild test --flake ~/repo/nixos/#laptop-nixos-allaine-cc";
      nob = "sudo nixos-rebuild boot --flake ~/repo/nixos/#laptop-nixos-allaine-cc";
      nixconf = "sudo nano /etc/nixos/configuration.nix";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor" = "eDP-1,1920x1080@60,0x0,1.25";

      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun -show-icons";

      exec-once = ''${startupScript}/bin/start'';

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        "gaps_in" = 5;
        "gaps_out" = 8;
        "border_size" = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        "resize_on_border" = false;
        "allow_tearing" = false;
        "layout" = "dwindle";
      };

      decoration = {
        "rounding" = 10;
        "active_opacity" = 0.9;
        "inactive_opacity" = 0.7;
        shadow = {
          enabled = true;
          "range" = 4;
          "render_power" = 3;
          "color" = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          "size" = 3;
          "passes" = 1;
          "vibrancy" = 0.1696;
        };
      };

      animations = {
        enabled = "yes";
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

      gestures = {
        "workspace_swipe" = true;
      };

      device = {
        "name" = "epic-mouse-v1";
        "sensitivity" = -0.5;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, T, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, L, exec, hyprlock"

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

        "$mainMod, PRINT, exec, hyprshot -m region"
        "$mainMod, F11, fullscreen"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
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
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 8;
        margin-top = 6;
        margin-left = 6;
        margin-right = 6;
        reload_style_on_change = true;
        # Disposition
        modules-left = [
          "custom/nixos"
          "custom/media"
          "tray"
          "custom/notifications"
          "privacy"
        ];
        modules-center = [
          "hyprland/window"
          "wlr/taskbar"
        ];
        modules-right = [
          "hyprland/language"
          "network"
          "bluetooth"
          "battery"
          "clock"
        ];
        # Bouton NixOS avec menu drawer
        "custom/nixos" = {
          format = "";
          tooltip = false;
          on-click = "~/.config/waybar/scripts/nixos-menu.sh";
        };
        # Espaces de travail Hyprland
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
          persistent-workspaces = {
            "*" = 3;
          };
          on-click = "activate";
        };
        # Lecteur multimédia
        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          format-icons = {
            Playing = "⏸";
            Paused = "▶";
            Stopped = "⏹";
          };
          max-length = 40;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} = {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
          smooth-scrolling-threshold = 10;
        };
        # Vérification des mises à jour NixOS
        "custom/nix-updates" = {
          exec = "~/.config/waybar/scripts/update-checker.sh";
          signal = 12;
          on-click = ""; # refresh on click
          on-click-right = "rm ~/.cache/nix-update-last-run"; # force an update
          interval = 43200;
          tooltip = true;
          return-type = "json";
          format = "{} {icon}";
          format-icons = {
            "has-updates" = "󰚰";
            "updating" = "";
            "updated" = "";
            "error" = "";
          };
        };
        # Zone d'indicateurs personnalisés
        "custom/notifications" = {
          format = "{}";
          exec = "~/.config/waybar/scripts/notifications.sh";
          return-type = "json";
          interval = 3600;
          tooltip = true;
        };
        # Zone d'applications système (tray)
        "tray" = {
          icon-size = 18;
          spacing = 8;
          show-passive-items = true;
        };
        # Module privacy (audio, écran partagé, etc.)
        "privacy" = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              "type" = "screenshare";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-out";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-in";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
          ];
        };
        # Fenêtre active
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
          rewrite = {
            "(.*) - Visual Studio Code" = "💻 $1";
          };
        };
        # Applications ouvertes
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 16;
          spacing = 3;
          on-click-middle = "close";
          tooltip-format = "{title}";
          ignore-list = [ ];
          on-click = "activate";
        };
        # Langue du clavier (module natif hyprland/language)
        "hyprland/language" = {
          format = "{}";
          format-en = "🇬🇧";
          format-us = "🇺🇸";
          format-fr = "🇫🇷";
          format-de = "🇩🇪";
          format-es = "🇪🇸";
          format-it = "🇮🇹";
          format-ru = "🇷🇺";
          format-zh = "🇨🇳";
          format-ja = "🇯🇵";
          format-ko = "🇰🇷";
          format-ar = "🇸🇦";
          keyboard-name = "at-translated-set-2-keyboard";
          on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
        };
        # Réseau WiFi
        "network" = {
          format-wifi = "";
          format-ethernet = "🌐 {ipaddr}";
          format-linked = "🌐 {ifname} (No IP)";
          format-disconnected = "⚠ Déconnecté";
          tooltip-format = "{essid}\n{ipaddr}/{cidr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
          tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}";
          tooltip-format-linked = "{fname} (No IP)";
          tooltip-format-disconnected = "Déconnecté";
          max-length = 50;
          on-click = "~/.config/waybar/scripts/networkmanager.sh";
        };
        # Bluetooth
        "bluetooth" = {
          format = "";
          format-disabled = "󰂲";
          format-connected = " {num_connections}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };
        # Batterie
        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "{timeTo}, {capacity}%";
          on-click = "~/.config/waybar/scripts/power-menu.sh";
        };
        # Horloge
        "clock" = {
          timezone = "Europe/Paris";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%H:%M}";
          format-alt = "{:%A %d %B %Y}";
          locale = "fr_FR.UTF-8";
          calendar = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>S{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font Mono";
        font-size: 13px;
        font-weight: bold;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0);
        border-radius: 15px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      #custom-nixos {
        background: linear-gradient(135deg, #89b4fa, #cba6f7);
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0 4px 4px;
        border-radius: 11px;
        font-size: 20px;
        transition: all 0.3s ease;
      }

      #custom-nixos:hover {
        background: linear-gradient(135deg, #cba6f7, #f5c2e7);
      }

      #custom-media {
        background: linear-gradient(135deg, #89b4fa, #cba6f7);
        color: #1e1e2e;
        padding: 0 15px;
        margin: 4px 0;
        border-radius: 11px;
        transition: all 0.3s ease;
      }

      #custom-media.Playing {
        background: linear-gradient(135deg, #f9e2af, #fab387);
      }

      #custom-media.Paused {
        background: linear-gradient(135deg, #a6e3a1, #94e2d5);
      }

      #custom-media.Stopped {
        background: linear-gradient(135deg, #f38ba8, #eba0ac);
      }

      #tray {
        background-color: #313244;
        padding: 0 10px;
        margin: 4px 0;
        border-radius: 11px;
      }

      #custom-notifications {
        background: linear-gradient(135deg, #f9e2af, #fab387);
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0;
        border-radius: 11px;
      }

      #privacy {
        background-color: #f38ba8;
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0;
        border-radius: 11px;
      }

      #window {
        background: linear-gradient(135deg, #74c7ec, #89b4fa);
        color: #1e1e2e;
        padding: 0 15px;
        margin: 4px;
        border-radius: 11px;
        font-weight: bold;
      }

      window#waybar.empty #window {  
        background:none;  
      }  

      #workspaces {
        background-color: #313244;
        margin: 4px;
        border-radius: 11px;
        padding: 0 4px;
      }

      #workspaces button {
        padding: 4px 10px;
        color: #cdd6f4;
        background-color: transparent;
        border-radius: 11px;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        background-color: #45475a;
        color: #89b4fa;
      }

      #workspaces button.active {
        background: linear-gradient(135deg, #89b4fa, #cba6f7);
        color: #1e1e2e;
      }

      #taskbar {
        background: linear-gradient(135deg, #89b4fa, #cba6f7);
        color: #1e1e2e;
        padding: 0;
        margin: 4px 0;
        border-radius: 11px;
      }

      #taskbar button {
        padding: 4px 10px;
        color: #cdd6f4;
        background-color: transparent;
        border-radius: 11px;
        transition: all 0.3s ease;
      }

      #taskbar.empty {
        background: transparent;
      }

      #language {
        background: linear-gradient(135deg, #a6e3a1, #94e2d5);
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0;
        border-radius: 11px;
        transition: all 0.3s ease;
      }

      #language:hover {
        background: linear-gradient(135deg, #94e2d5, #89dceb);
      }

      #network {
        background: linear-gradient(135deg, #89dceb, #74c7ec);
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0;
        border-radius: 11px;
        font-size: 20px;
      }

      #bluetooth {
        background-color: #cba6f7;
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0;
        border-radius: 11px;
        font-size: 15px;
      }

      #battery {
        background: linear-gradient(135deg, #a6e3a1, #94e2d5);
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 0;
        border-radius: 11px;
      }

      #battery.charging {
        background: linear-gradient(135deg, #f9e2af, #fab387);
      }

      #battery.warning:not(.charging) {
        background: linear-gradient(135deg, #fab387, #f38ba8);
        color: #1e1e2e;
      }

      #battery.critical:not(.charging) {
        background-color: #f38ba8;
        color: #1e1e2e;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background-color: #eba0ac;
        }
      }

      #clock {
        background: linear-gradient(135deg, #f9e2af, #f2cdcd);
        color: #1e1e2e;
        padding: 0 12px;
        margin: 4px 4px 4px 0;
        border-radius: 11px;
      }

      .modules-left>widget:hover child,
      .modules-center>widget:hover child,
      .modules-right>widget:hover child {
        transition: all 0.2s ease;
      }

      tooltip {
        background-color: #1e1e2e;
        border: 2px solid #89b4fa;
        border-radius: 10px;
        color: #cdd6f4;
      }

      tooltip label {
        color: #cdd6f4;
      }
    '';
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
      };
      background = {
        monitor = { };
        path = "${config.home.homeDirectory}/wallpaper/landscape.jpg";
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      input-field = {
        monitor = { };
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        font_family = "JetBrains Mono Nerd Font Mono";
        placeholder_text = "<i><span foreground='##cdd6f4'>Input Password...</span></i>";
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          monitor = { };
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M%p\")\"";
          color = "$foreground";
          font_size = 120;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }
        {
          monitor = { };
          text = "Salut Grand fan, $DESC";
          color = "$foreground";
          font_size = 25;
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      placeholders."default".input = "Example";
      providers.prefixes = [
        {provider = "websearch"; prefix = "+";}
        {provider = "providerlist"; prefix = "_";}
      ];
      keybinds.quick_activate = ["F1" "F2" "F3"];
      theme = "nixos";
    };
    themes.nixos = {
      style = ''
        * {
            color: #dcd7ba;
        }
      '';
    };
  };

  gtk = {
    enable = true;
    font.name = "Montserrat 10";
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      #   name = "WhiteSur";
      #   package = pkgs.whitesur-icon-theme;
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  qt = {
    enable = true;
  };

  programs.kitty.enable = true;

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  programs.vscode.enable = true;
  home.file.".vscode/argv.json" = {
    force = true;
    text = ''
      {
        "enable-crash-reporter": true,
        "password-store": "gnome",
        "locale": "fr"
      }
    '';
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
