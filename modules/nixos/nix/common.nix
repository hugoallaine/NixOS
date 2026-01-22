{ ... }:
{
  nix.settings = {
    download-buffer-size = 1024 * 1024 * 1024; # 1 GiB
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Enable nix-ld for classic python environments
  programs.nix-ld.enable = true;
}