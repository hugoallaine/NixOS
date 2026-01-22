{ ... }:
{
  imports = [
    ../../../modules/home/users/hallaine_hm.nix
    ../../../modules/home/environment/path.nix
    ../../../modules/home/environment/vars.nix
    ../../../modules/home/config/window_manager/uwsm.nix
    ../../../modules/home/config/window_manager/hyprland.nix
    ../../../modules/home/config/desktop/dms.nix
    ../../../modules/home/config/shell/bash.nix
    ../../../modules/home/config/shell/kitty.nix
    ../../../modules/home/config/packages/cli.nix
    ../../../modules/home/config/packages/desktop.nix
    ../../../modules/home/config/packages/games.nix
    ../../../modules/home/config/packages/mediaplayer.nix
    ../../../modules/home/config/packages/security.nix
    ../../../modules/home/config/theme/gtk.nix
    ../../../modules/home/config/theme/qt.nix
    ../../../modules/home/config/git.nix
    ../../../modules/home/config/vscode.nix
  ];
  
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}