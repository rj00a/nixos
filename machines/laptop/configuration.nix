{ config, pkgs, ... }:

{
  imports = [ ../../common.nix ./hardware-configuration.nix ];

  networking.hostName = "rjlaptop";

  services.xserver = {
    libinput = {
      enable = true;
      tapping = false; # Disables tap to click
    };
    windowManager.bspwm.configFile = ./bspwmrc;
  };

  programs.light.enable = true;

  users.users.ryan.extraGroups = [
    "video" # For `light`
  ];

  home-manager.users.ryan.programs.alacritty.settings.font.size = 9;
}

