# Configuration specific to my Desktop computer
{ config, pkgs, ... }:

{
  imports = [ ../../common.nix ./hardware-configuration.nix ];

  networking.hostName = "rjpc";

  fileSystems."/mnt/sdb1".device = "/dev/sdb1";

  environment.systemPackages = with pkgs; [
    multimc
    jetbrains.idea-community
    jdk
    metals
    scala
    gradle
    qemu
  ];

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    windowManager.bspwm.configFile = ./bspwmrc;
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
    programs = {
      alacritty.settings.font.size = 12;
      #vscode = {
      #  enable = true;
      #  package = pkgs.vscodium;
      #  extensions = with pkgs.vscode-extensions; [
      #    redhat.vscode-yaml
      #    matklad.rust-analyzer
      #    vscodevim.vim
      #  ];
      #  # TODO: Enable haskell
      #  # TODO: Settings
      #};
    };
    services.polybar.config."bar/main".monitor = "HDMI-0";
    home.file = {
      ".ideavimrc".text = ''
        set so=999
        set ideajoin'';
    };
  };

}
