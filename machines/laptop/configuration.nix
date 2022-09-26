{ config, pkgs, ... }:

{
  imports = [ ../../common.nix ./hardware-configuration.nix ];

  environment.systemPackages = with pkgs;
    [ (import ../../nix/vscode.nix { inherit pkgs; }) ];

  networking.hostName = "rjlaptop";

  services = {
    logind.lidSwitch = "ignore";
  };

  services.xserver = {
    libinput = {
      enable = true;
      touchpad.tapping = false; # Disables tap to click
    };

    windowManager.bspwm.configFile = ./bspwmrc;
  };

  programs.light.enable = true;

  users.users.ryan.extraGroups = [
    "video" # For `light`
  ];

  home-manager.users.ryan.programs.alacritty.settings.font.size = 9;
}

