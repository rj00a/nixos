# Configuration specific to my Desktop computer
{ config, pkgs, ... }:

{
  imports = [ ../../common.nix ./hardware-configuration.nix ];

  environment.systemPackages = with pkgs;
    let
      my-vscode = import ../../nix/vscode.nix {
        inherit pkgs;
      };
      scala3 = stdenv.mkDerivation rec {
        version = "3.0.0";
        pname = "scala3";
        src = fetchurl {
          url =
            "https://github.com/lampepfl/dotty/releases/download/${version}/scala3-${version}.tar.gz";
          sha256 =
            "fc5db2bf85c7d08de80b7205aa3fa3c29cd2842b5311f4f383e276e9797e3fe6";
        };
        buildInputs = [ jre ncurses.dev makeWrapper ];
        installPhase = ''
          mkdir -p $out
          mv * $out
        '';
        fixupPhase = ''
          for f in $out/bin/{scala,scalac,scaladoc}; do
            wrapProgram $f --set JAVA_HOME ${jre} --prefix PATH : '${ncurses.dev}/bin'
          done
        '';
      };
    in [
      my-vscode
      kubernetes
      minikube
      ghc
      cabal-install
      rust-analyzer
      rustup
      cargo-flamegraph
      ghidra-bin
      gzdoom
      minecraft
      elan
      (agda.withPackages (p: [ p.standard-library ]))
    ];

  programs.steam.enable = true;

  networking.hostName = "rjpc";

  fileSystems = {
    "/mnt/bulk".device = "/dev/disk/by-label/Bulk";
    "/mnt/shared".device = "/dev/disk/by-label/SHARED";
  };

  #virtualisation.docker.enable = true;

  users.users.ryan.extraGroups = [ "docker" ];

  hardware.opengl.driSupport32Bit = true;

  services = {
    xserver = {

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.middleEmulation = false;
      };

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
    # Also needed for git askpass
    openssh = {
      enable = true;
      # Can only ssh into this machine from the localhost.
      listenAddresses = [{
        addr = "localhost";
        port = 22;
      }];
      #permitRootLogin = "yes";
    };
  };

  home-manager.users.ryan = {
    programs = { alacritty.settings.font.size = 12; };
    #home.file = {
    #  ".ideavimrc".text = ''
    #    set so=999
    #    set ideajoin
    #    set clipboard+=unnamedplus
    #    noremap Y y$
    #  '';
    #};
  };

}
