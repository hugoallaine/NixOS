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
    ../../../modules/nixos/window_manager/gnome.nix
    ../../../modules/nixos/display_manager/gdm.nix
    ../../../modules/nixos/security/gnome-keyring.nix
    ../../../modules/nixos/security/polkit.nix
    ../../../modules/nixos/security/sudo.nix
  ];

  system.stateVersion = "25.11";
}