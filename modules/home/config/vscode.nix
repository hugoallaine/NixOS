{ ... }:
{
  programs.vscode.enable = true;
  
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