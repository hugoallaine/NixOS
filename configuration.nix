# Laptop NixOS configuration
{
  config,
  pkgs,
  pkgs-unstable,
  hyprland,
  ...
}:

{
  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # Power Management
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  powerManagement.powertop.enable = true;
  services.logind.settings.Login.HandleLidSwitch = "suspend";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "suspend";
  services.logind.settings.Login.HandleLidSwitchDocked = "suspend";

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

  # Nix settings
  nix.settings = {
    download-buffer-size = 1024 * 1024 * 1024; # 1 GiB
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Cachix
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

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

  # Window manager
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "minesddm";
  };

  # Keyring and polkit
  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "hallaine" ];
        commands = [
          { command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
          { command = "${pkgs.nix}/bin/nix-collect-garbage"; options = [ "NOPASSWD" ]; }
          { command = "${pkgs.nix}/bin/nix-env"; options = [ "NOPASSWD" ]; }
          { command = "${pkgs.coreutils}/bin/du"; options = [ "NOPASSWD" ]; }
        ];
      }
    ];
  };

  # Other
  programs.steam.enable = true;
  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;

  # System version
  system.stateVersion = "24.11";
}
