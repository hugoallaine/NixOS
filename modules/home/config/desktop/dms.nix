{ pkgs, dgop, ... }:
{
  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    dgop.package = dgop.packages.${pkgs.system}.default;
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableClipboardPaste = true;       # Pasting items from the clipboard (wtype)
  };

  programs.nix-monitor = {
    enable = true;
    updateInterval = 3600;
    rebuildCommand = [ 
      "bash" "-c" 
      "cd ~/repo/nixos && nix flake update && sudo -n ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake ~/repo/nixos/#laptop-nixos-allaine-cc 2>&1"
    ];
    generationsCommand = [
      "bash" "-c" 
      "sudo -n ${pkgs.nix}/bin/nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l"
    ];
    storeSizeCommand = [
      "bash" "-c" 
      "sudo -n ${pkgs.coreutils}/bin/du -sh /nix/store | cut -f1"
    ];
    gcCommand = [ 
      "bash" "-c" 
      "sudo -n ${pkgs.nix}/bin/nix-collect-garbage -d 2>&1" 
    ];
    remoteRevisionCommand = [
      "bash" "-l" "-c"
      "curl -s https://api.github.com/repos/NixOS/nixpkgs/git/ref/heads/nixos-25.11 2>/dev/null | ${pkgs.jq}/bin/jq -r '.object.sha' 2>/dev/null | cut -c 1-7 || echo 'N/A'"
    ];
    nixpkgsChannel = "nixos-25.11";
  };
}