{ ... }:
{
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
}