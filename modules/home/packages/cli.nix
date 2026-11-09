{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs;
  [
    # Nix FMT
    nixfmt

    # Task Manager
    btop

    # Shell enhancements
    zoxide
    mcfly
    git
    playerctl
    screen
    fastfetch
    unzip

    # Kubernetes
    kubectl
    kubernetes-helm

    # File editor
    msedit

    # Python environment manager
    uv

    # AI
    codex
  ];
}