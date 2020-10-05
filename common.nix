# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      ascii
      audacity
      bitwarden
      cabal-install
      cabal2nix
      colordiff
      #corefonts #TODO: hash mismatch
      discord
      dmenu
      exif
      fd
      ffmpeg
      file
      gdb
      ghc
      git
      gperf
      htop
      imagemagick
      jq
      krita
      lshw
      lxappearance
      maim
      ncdu
      neofetch
      nixfmt
      nmap
      pandoc
      perl # fzf-history-widget complains if this isn't available.
      playerctl
      python3
      ripgrep
      rustup
      scc
      shellcheck
      strace
      sxiv
      traceroute
      trash-cli
      tree
      unrar
      unzip
      valgrind
      veracrypt
      wget
      woeusb
      xclip
      xfce.thunar
      youtube-dl
      zathura
      zip
      zsh
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions;
          [
            matklad.rust-analyzer
            vadimcn.vscode-lldb
            vscodevim.vim
            ms-kubernetes-tools.vscode-kubernetes-tools
            redhat.vscode-yaml
            bbenoist.Nix
          ] ++ vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "theme-dracula";
              publisher = "dracula-theme";
              version = "2.22.1";
              sha256 =
                "517f5e96a8393e3c8d3f7b0ef30e2df0ff00b9d77167b2705c61a5a9bcdaa88f";
            }
            {
              name = "nixfmt-vscode";
              publisher = "brettm12345";
              version = "0.0.1";
              sha256 =
                "f3282540351cd025c6d84322dbf1d70c9b31997278607be33634cc9d0c2b831f";
            }
            {
              name = "nix-env-selector";
              publisher = "arrterian";
              version = "0.1.2";
              sha256 =
                "693371af5b1a51a37d23cd946020ec42f1fd5015a3b9efc14a75263103a7b1d8";
            }
            {
              name = "material-icon-theme";
              publisher = "pkief";
              version = "4.3.0";
              sha256 =
                "3020202de6f572528f7c194b7c74f5d7c242cd9e27f44239bd8cb4076b9bc9a8";
            }
            {
              name = "shellcheck";
              publisher = "timonwong";
              version = "0.11.0";
              sha256 =
                "b332f80ebb8b7dafc14c157d95b3c90436d5c98bfc7a165d4760e893abd71049";
            }
          ];
      })
    ];
    pathsToLink = [
      "/share/zsh" # zsh completions for system packages.
    ];
  };

  # TODO: Emojis are a mix of flat colorless and twitter ones.
  fonts = {
    fonts = with pkgs; [
      ubuntu_font_family
      twitter-color-emoji
      noto-fonts
      #noto-fonts-cjk
      #noto-fonts-extra
      #source-code-pro
    ];
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Twitter Color Emoji" ];
    };
    enableFontDir = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    # Don't forget to set a password with ‘passwd’.
    users.ryan = {
      isNormalUser = true;
      # wheel is for sudo.
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 0;
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 100;
    };
  };

  swapDevices = [{
    device = "/var/swapfile";
    size = 8192;
  }];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "America/Los_Angeles";

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip # Driver for HP printers.
    ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:swapescape";
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };
        cursorTheme = {
          package = pkgs.numix-cursor-theme;
          name = "Numix-Cursor-Light";
        };
      };
      background = files/wallpaper.jpg;
    };
    # Note: Letting home-manager handle this gave me problems.
    windowManager.bspwm = {
      enable = true;
      sxhkd.configFile = files/sxhkdrc;
    };
    autoRepeatDelay = 250;
    autoRepeatInterval = 25;
  };

  programs.dconf.enable =
    true; # Required for setting gtk theme in home manager.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

