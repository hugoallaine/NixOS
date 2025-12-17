{
  description = "Hugo Allainé | Laptop NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    minesddm = {
      url = "github:Davi-S/sddm-theme-minesddm/ee7b44ab7e27b0f4fafc59d7cc8f1cf35ecfa776";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      # lanzaboote,
      home-manager,
      dms,
      minegrub-theme,
      minegrub-world-sel-theme,
      minesddm,
      ...
    }:
    {
      nixosConfigurations = {

        laptop-nixos-allaine-cc = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            ./configuration.nix
            # lanzaboote.nixosModules.lanzaboote
            # ({ pkgs, lib, ... }: {

            #   environment.systemPackages = [
            #     pkgs.sbctl
            #   ];
            #   boot.loader.systemd-boot.enable = lib.mkForce false;
            #   boot.lanzaboote = {
            #     enable = true;
            #     pkiBundle = "/var/lib/sbctl";
            #   };
            # })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hallaine = { ... }: {
                imports = [
                  ./home.nix
                  dms.homeModules.dankMaterialShell.default
                ];
              };
              home-manager.extraSpecialArgs = {
                pkgs-unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = true;
                };
              };
            }
            minegrub-theme.nixosModules.default
            minegrub-world-sel-theme.nixosModules.default
            minesddm.nixosModules.default
          ];
        };
      };
    };
}
