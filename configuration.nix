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
  hardware.bluetooth.powerOnBoot = false;

  # Power Management
  services.tlp.enable = true;
  powerManagement.powertop.enable = true;
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.lidSwitchDocked = "suspend";

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
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix flakes
  nix.settings.download-buffer-size = 1024 * 1024 * 1024; # 1 GiB
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
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "minesddm";

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.polkit.enable = true;

  programs.steam.enable = true;
  virtualisation.docker.enable = true;

  # System version
  system.stateVersion = "24.11";
}
