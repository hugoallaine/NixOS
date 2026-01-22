{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "hugoallaine";
      user.email = "hugo+github@allaine.cc";
    };
  };
}