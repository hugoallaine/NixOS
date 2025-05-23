# hallaine's home-manager configuration
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

#${pkgs.swww}/bin/swww init &
#${pkgs.swww}/bin/swww img /home/hallaine/wallpaper/landscape.jpg

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine --screen-root eDP-1 1216525525 &
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
    ${pkgs.blueman}/bin/blueman-applet &
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.dunst}/bin/dunst
  '';
in
{
  home.username = "hallaine";
  home.homeDirectory = "/home/hallaine";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "nano";
    XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
    XDG_VIDEOS_DIR = "${config.home.homeDirectory}/Videos";
    XDG_MUSIC_DIR = "${config.home.homeDirectory}/Musics";
    XDG_DOWNLOAD_DIR = "${config.home.homeDirectory}/Downloads";
    HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
  };

  home.packages = with pkgs; [
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

    # Hyprland
    waybar
    swww
    linux-wallpaperengine
    rofi-wayland
    dunst
    libnotify
    networkmanagerapplet
    blueman
    hyprshot
    hyprlock
    kdePackages.dolphin
    kdePackages.qtsvg

    # Keyring
    gcr
    seahorse

    # Web Browser
    brave

    # Media player
    plexamp
    vlc

    # Pictures editor
    gimp

    # Communications
    discord
    element-desktop

    # Games
    solitaire-tui
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
      "$menu" = "rofi -show drun";

      exec-once = ''${startupScript}/bin/start'';

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        "gaps_in" = 5;
        "gaps_out" = 20;
        "border_size" = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        "resize_on_border" = false;
        "allow_tearing" = false;
        "layout" = "dwindle";
      };

      decoration = {
        "rounding" = 10;
        "active_opacity" = 1.0;
        "inactive_opacity" = 1.0;
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
        "kb_variant" = "nodeadkeys,";
        "kb_options" = "grp:alt_shift_toggle";

        "follow_mouse" = 1;

        "sensitivity" = 0;

        touchpad = {
          "natural_scroll" = false;
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

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
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
