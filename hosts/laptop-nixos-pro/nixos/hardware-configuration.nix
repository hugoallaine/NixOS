{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ]
  boot.initrd.kernelModules = [ ];
  boot.initrd.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1bd6a941-84d0-4891-a988-0cf01222c927";
      fsType = "ext4";
    };
  
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1971-550D";
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