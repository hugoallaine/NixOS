{ pkgs, ... }:
let
  # TODO: retirer quand nixos-26.05 aura le fix ripgrep-universal pour VSCode >= 1.122
  vscodeFixed = pkgs.vscode.overrideAttrs (old: {
    postPatch = builtins.replaceStrings
      [ "resources/app/node_modules/@vscode/ripgrep/bin/rg" ]
      [ "resources/app/node_modules/@vscode/ripgrep-universal/bin/linux-x64/rg" ]
      old.postPatch;
  });
in
{
  programs.vscode = {
    enable = true;
    package = vscodeFixed;
  };

  home.file.".vscode/argv.json" = {
    force = true;
    text = ''
      {
        "enable-crash-reporter": true,
        "password-store": "gnome",
        "locale": "fr"
      }
    '';
  };
}