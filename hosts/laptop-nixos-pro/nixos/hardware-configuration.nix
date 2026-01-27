{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/421555b6-87e5-4147-9878-eb345906b2e7";
      fsType = "ext4";
    };
  
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/72C5-57CB";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  
  swapDevices =
    [ { device = "/dev/disk/by-uuid/64cefef6-83b0-4cc2-9b68-8145e396efaa"; } 
    ];
  
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  virtualisation.virtualbox.guest.enable = true;
}