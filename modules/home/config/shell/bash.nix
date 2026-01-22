{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    bashrcExtra = ''
      eval "$(zoxide init bash)"
      eval "$(mcfly init bash)"
      export MCFLY_RESULTS=50
      export MCFLY_RESULTS_SORT=LAST_RUN
    '';

    shellAliases = {
      cd = "z";
      cdi = "zi";
      nos = "sudo nixos-rebuild switch --flake ~/repo/nixos/#laptop-nixos-allaine-cc";
      not = "sudo nixos-rebuild test --flake ~/repo/nixos/#laptop-nixos-allaine-cc";
      nob = "sudo nixos-rebuild boot --flake ~/repo/nixos/#laptop-nixos-allaine-cc";
      nixconf = "sudo nano /etc/nixos/configuration.nix";
    };
  };
}