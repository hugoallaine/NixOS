# Laptop NixOS configuration
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
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
          lineBottom = "Version: 25.05";
          imgName = "nixos";
        }
      ];
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "laptop-nixos-allaine-cc";
  networking.networkmanager.enable = true;
  networking.wg-quick.interfaces.NAS.configFile = "/home/hallaine/vpn/nas.conf";
  networking.extraHosts = "192.168.1.202 prod.nasdak.fr";

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Power Management
  services.power-profiles-daemon.enable = true;

  # Time zone
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Users
  users.users.hallaine = {
    isNormalUser = true;
    description = "Hugo Allainé";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  # NAS
  fileSystems."/mnt/NAS/hallaine" = {
    device = "//192.168.1.100/Utilisateurs/hallaine";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/smbcredentials" ];
  };

  # Apps
  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "minesddm";

  security.pam.services.login.enableGnomeKeyring = true;

  programs.steam.enable = true;

  # System version
  system.stateVersion = "24.11";
}
