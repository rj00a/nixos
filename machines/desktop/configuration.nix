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
    metals
    scala
    gradle
    nixops
  ];

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  users.users.ryan.extraGroups = [ "vboxusers" ];

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
        --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal &> /home/ryan/foo.txt
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

      autorandr = {
        enable = true;
        profiles.main = {
          fingerprint = {
            DVI-D-0 =
              "00ffffffffffff000469e124010101012c19010380351e78ea9de5a654549f260d5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c4500132b2100001e000000fd0032961ea021000a202020202020000000fc0056473234380a20202020202020000000ff0046414c4d51533130353735370a01d2020104008a4d80a070382c4030203500132b2100001afe5b80a07038354030203500132b2100001a866f80a07038404030203500132b2100001afc7e80887038124018203500132b2100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb";
            HDMI-0 =
              "00ffffffffffff0010ac59d0545652342b16010380331d78eae295a2554f9f26115054a54b00714f8180d1c001010101010101010101023a801871382d40582c4500fd1e1100001e000000ff003239334d3332414e345256540a000000fc0044454c4c2053323334304d0a20000000fd00384c1e5311000a202020202020014402031b61230907078301000067030c002000802d43908402e2000f8c0ad08a20e02d10103e9600a05a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";
          };
          config = {
            HDMI-0 = {
              position = "0x0";
              mode = "1920x1080";
              rate = "60.00";
            };
            DVI-D-0 = {
              position = "1920x0";
              mode = "1920x1080";
              rate = "144.00";
              primary = true;
            };
          };
        };
      };
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
