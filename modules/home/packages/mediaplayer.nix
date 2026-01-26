{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    # Music player
    plexamp
    spotify

    # Video player
    vlc
  ];
}