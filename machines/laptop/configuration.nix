{ config, pkgs, ... }:

{
  imports = [ ../../common.nix ./hardware-configuration.nix ];

  environment.systemPackages = with pkgs;
    [ (import ../../files/vscode.nix { inherit pkgs; }) ];

  networking.hostName = "rjlaptop";

  services.xserver = {
    libinput = {
      enable = true;
      tapping = false; # Disables tap to click
    };

    logind.lidSwitch = "ignore";

    windowManager.bspwm.configFile = ./bspwmrc;
  };

  programs.light.enable = true;

  users.users.ryan.extraGroups = [
    "video" # For `light`
  ];

  home-manager.users.ryan.programs.alacritty.settings.font.size = 9;
}

