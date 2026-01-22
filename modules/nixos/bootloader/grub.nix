{ ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
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