# Configuration specific to my Desktop computer
{ config, pkgs, ... }:

{
  imports = [ ../../common.nix ./hardware-configuration.nix ];

  networking.hostName = "rjpc";

  fileSystems."/mnt/bulk".device = "/dev/disk/by-label/Bulk";

  environment.systemPackages = with pkgs; [
    steam
    multimc
    jetbrains.idea-community
    jdk
    #metals
    scala
    gradle
    sbt
    docker
    kubernetes
    minikube
  ];

  virtualisation.docker.enable = true;

  users.users.ryan.extraGroups = [ "docker" ];

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      windowManager.bspwm.configFile = ./bspwmrc;
      wacom.enable = true;
      config = ''
        # Disable mouse acceleration
        Section "InputClass"
          Identifier "mouse accel"
          Driver "libinput"
          MatchIsPointer "on"
          Option "AccelProfile" "flat"
          Option "AccelSpeed" "0"
        EndSection
      '';

      displayManager.sessionCommands = ''
        xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 144 \
        --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal &
      '';
    };
    openssh = {
      enable = true;
      # Can only ssh into this machine from the localhost.
      listenAddresses = [{
        addr = "localhost";
        port = 22;
      }];
      permitRootLogin = "yes";
    };
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
    home.file = {
      ".ideavimrc".text = ''
        set so=999
        set ideajoin
        set clipboard+=unnamedplus
        noremap Y y$
      '';
    };
  };

}
