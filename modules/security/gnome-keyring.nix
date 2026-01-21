{ ... }:
{
  services.gnome.gnome-keyring.enable = true;
  
  security.pam.services = {
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
}