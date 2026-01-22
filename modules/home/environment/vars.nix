{ config, ... }:
{
  home.sessionVariables = {
    XCURSOR_SIZE = 24;
    HYPRCURSOR_SIZE = 24;
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nano";
    TERM = "xterm";
    XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
    XDG_VIDEOS_DIR = "${config.home.homeDirectory}/Videos";
    XDG_MUSIC_DIR = "${config.home.homeDirectory}/Musics";
    XDG_DOWNLOAD_DIR = "${config.home.homeDirectory}/Downloads";
  };
}