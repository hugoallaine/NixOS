{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    # Games
    solitaire-tui
    melonDS
    prismlauncher
  ];
}