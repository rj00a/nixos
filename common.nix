# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      arandr
      ascii
      audacity
      bitwarden
      colordiff
      corefonts
      dmenu
      fd
      ffmpeg
      file
      gdb
      ghc
      git
      gperf
      htop
      jq
      krita
      lxappearance
      maim
      ncdu
      neofetch
      nixfmt
      nixops
      nmap
      pandoc
      playerctl
      python3
      ripgrep
      scc
      shellcheck
      steam
      strace
      sxiv
      trash-cli
      tree
      unrar
      unzip
      valgrind
      veracrypt
      wget
      woeusb
      xclip
      youtube-dl
      zathura
      zip
      zsh
    ];
    pathsToLink = [
      "/share/zsh" # zsh completions for system packages.
    ];
  };

  fonts = {
    fonts = with pkgs; [
      ubuntu_font_family
      twitter-color-emoji
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      source-code-pro
    ];
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Twitter Color Emoji" ];
      penultimate.enable = true;
    };
    enableFontDir = true;
  };

  security.sudo.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    # Don't forget to set a password with ‘passwd’.
    users.ryan = {
      isNormalUser = true;
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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
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
    libinput = {
      enable = true;
      accelProfile = "flat";
    };
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

