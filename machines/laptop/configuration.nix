{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "rjlaptop";

  services.xserver.libinput = {
    enable = true;
    tapping = false; # Disables tap to click
  };

  home-manager.users.ryan.xsession.windowManager.bspwm.monitors = {
    "eDP-1" = [ "1" "2" "3" "4" "5" "6" ];
  };
}

