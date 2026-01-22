{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs;
  [
    # Nix FMT
    nixfmt-rfc-style

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
    pkgs-unstable.msedit

    # Python environment manager
    uv

    # AI
    codex
  ];
}