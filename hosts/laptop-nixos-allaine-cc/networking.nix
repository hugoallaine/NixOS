{ ... }:
{
  networking.wg-quick.interfaces.NAS.configFile = "/home/hallaine/vpn/nas.conf";
  networking.extraHosts = "192.168.1.202 prod.nasdak.fr";
}
