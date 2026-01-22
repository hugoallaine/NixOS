{ config, ... }:
{
  home.sessionPath = [
    "${config.home.homeDirectory}/.config/waybar/scripts"
    "${config.home.homeDirectory}/.local/bin"
  ];
}