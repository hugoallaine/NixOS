{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/nixos/bootloader/grub.nix
    ../../../modules/nixos/networking/common.nix
    ../../../modules/nixos/power/common.nix
    ../../../modules/nixos/locale/common.nix
    ../../../modules/nixos/users/hallaine_nixos.nix
    ../../../modules/nixos/nix/common.nix
    ../../../modules/nixos/fonts/common.nix
    ../../../modules/nixos/packages/common.nix
    ../../../modules/nixos/window_manager/hyprland.nix
    ../../../modules/nixos/display_manager/sddm.nix
    ../../../modules/nixos/security/gnome-keyring.nix
    ../../../modules/nixos/security/polkit.nix
    ../../../modules/nixos/security/sudo.nix
    ../../../modules/nixos/games/steam.nix
    ../../../modules/nixos/virtualisation/docker.nix
    ./networking.nix
    ./samba.nix
  ];
  
  system.stateVersion = "24.11";
}