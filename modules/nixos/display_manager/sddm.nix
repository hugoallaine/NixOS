{ pkgs, ... }:
{
  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #package = pkgs.kdePackages.sddm;
    theme = "minesddm";
  };
}