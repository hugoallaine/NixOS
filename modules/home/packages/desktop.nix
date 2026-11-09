{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    # Polkit agent
    hyprpolkitagent

    # Web browser
    firefox

    # File manager
    thunar

    # Wallpaper Engine
    linux-wallpaperengine

    # Calculator
    galculator

    # Office
    onlyoffice-desktopeditors

    # Pictures editor
    gimp

    # Communications
    discord
    element-desktop # Bug in 25.05, need to launch once manually with --password-store=gnome-libsecret to use keyring

    # Server Management
    ipmiview
  ];
}