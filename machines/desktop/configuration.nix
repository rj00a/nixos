# Configuration specific to my Desktop computer
{ config, pkgs, ... }:

{
  imports = [ ./common.nix ./hardware-configuration.nix ];

  networking.hostName = "rjpc";

  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
  ];

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    windowManager.bspwm.configFile = machines/desktop/bspwmrc;
    wacom.enable = true;
    config = ''
      Section "InputClass"
        Identifier "mouse accel"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection
    '';
  };

  home-manager.users.ryan = {
    programs.alacritty.settings.font.size = 12;
    services.polybar.config."bar/main".monitor = "HDMI-0";
    #home.file = {
    #  ".xinitrc".text = ''
    #    # Generated with the help of `arandr`
    #    # (--rate sets the refresh rate)
    #    xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 144 --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal
    #    # vim: set ft=sh'';
    #};
  };

}
