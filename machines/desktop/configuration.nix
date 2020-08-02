# Configuration specific to my Desktop computer
{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "rjpc";
    wireless.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  home-manager.users.ryan.xsession.windowManager.bspwm.monitors = {
    "DVI-D-0" = [ "1" "2" "3" ];
    "HDMI-0" = [ "4" "5" "6" ];
  };
}
