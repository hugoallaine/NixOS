{
  description = "Hugo Allainé | NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-monitor = {
      url = "github:antonjah/nix-monitor";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    minesddm = {
      url = "github:Davi-S/sddm-theme-minesddm/ee7b44ab7e27b0f4fafc59d7cc8f1cf35ecfa776";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      commonArgs = {
        inherit (inputs) hyprland dgop;
        pkgs-unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {

        laptop-nixos-allaine-cc = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hallaine = { ... }: {
                imports = [
                  ./home.nix
                  inputs.dms.homeModules.dank-material-shell
                  inputs.nix-monitor.homeManagerModules.default
                ];
              };
              home-manager.extraSpecialArgs = commonArgs;
            }
            inputs.minegrub-theme.nixosModules.default
            inputs.minegrub-world-sel-theme.nixosModules.default
            inputs.minesddm.nixosModules.default
          ];
        };

      };
    };
}
