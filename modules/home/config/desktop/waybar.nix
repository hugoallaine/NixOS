{ ... }:
{
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
}