{ hostName, ... }:
{
  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
}
