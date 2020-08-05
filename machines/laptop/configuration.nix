{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "rjlaptop";

  services.xserver = {
    libinput = {
      tapping = false; # Disables tap to click
    };
    windowManager.bspwm.configFile = machines/laptop/bspwmrc;
  };

  programs.light.enable = true;

  users.users.ryan.extraGroups = [
    "video" # For `light`
  ];
}

