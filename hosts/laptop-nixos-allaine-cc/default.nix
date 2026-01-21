{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./samba.nix
  ];
  
  system.stateVersion = "24.11";
}