{ pkgs-unstable, ... }:
{
  # grub-secureboot needs GRUB >= 2.14 (--disable-cli); NixOS 26.05 ships 2.12.
  # shortcut: drop this overlay once on NixOS 26.11.
  nixpkgs.overlays = [ (_: _: { grub2 = pkgs-unstable.grub2; }) ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    secureBoot = {
      enable = true;
      # Enrolls the keys (with Microsoft certs) on rebuild while the firmware is in Setup Mode.
      autoEnrollKeys.enable = true;
    };
    extraEntries = ''
      menuentry "UEFI Firmware Settings" {
          fwsetup
      }
    '';

    minegrub-theme = {
      enable = false;
      splash = "100% Flakes!";
      background = "background_options/1.8  - [Classic Minecraft].png";
      boot-options-count = 4;
    };

    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "allaine.cc";
          lineBottom = "Version: 25.11";
          imgName = "nixos";
        }
      ];
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
}