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

  #home-manager.users.ryan.xsession.windowManager.bspwm.monitors = {
  #  "eDP-1" = [ "1" "2" "3" "4" "5" "6" ];
  #};
  home-manager.users.ryan.xsession.windowManager.bspwm.extraConfig =
    "bspc monitor eDP-1 -d 1 2 3 4 5 6"; # bspwm.monitors wasn't working.

  programs.light.enable = true;

  users.users.ryan.extraGroups = [
    "video" # For `light`
  ];

  services.xserver = {
    libinput = {
      enable = true;
      tapping = false;
    };
    windowManager.bspwm.configFile =
      builtins.toFile (builtins.readFile files/bspwmrc + "bspc monitor eDP-1 -d 1 2 3 4 5 6");
  };

}

