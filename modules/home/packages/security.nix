{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    gcr
    seahorse
  ];
}