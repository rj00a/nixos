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
      capitaine-cursors
      corefonts
      dmenu
      file
      ghc
      git
      gperf
      htop
      jq
      krita
      maim
      ncdu
      neofetch
      neovim
      nixfmt
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      pandoc
      playerctl
      ripgrep
      ripgrep
      scc
      shellcheck
      steam
      strace
      sxiv
      tree
      unrar
      unzip
      valgrind
      veracrypt
      wget
      woeusb
      youtube-dl
      zathura
      zip
      zsh      
    ];
    pathsToLink = [
      "/share/zsh" # zsh completions for system packages.
    ];
  };

  security.sudo = {
    enable = true;
    extraConfig = "%wheel ALL=(ALL) NOPASSWD: ALL";
  };

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

  #programs.zsh = {
  #  enable = true;
  #  autosuggestions.enable = true;
  #  enableCompletion = true;
  #  histSize = 10000;
  #  ohMyZsh.enable = true;
  #  interactiveShellInit = builtins.readFile files/init.zsh;
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

