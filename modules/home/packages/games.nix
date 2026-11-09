{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    # Games
    solitaire-tui
    melonds
    prismlauncher
  ];
}