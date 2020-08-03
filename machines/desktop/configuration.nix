# Configuration specific to my Desktop computer
{ config, pkgs, ... }:

{
  imports = [ ./common.nix ./hardware-configuration.nix ];

  networking = {
    hostName = "rjpc";
    wireless.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    windowManager.bspwm.configFile = machines/desktop/bspwmrc;
  };
}
