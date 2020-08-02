# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./home.nix ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    ascii
    audacity
    bitwarden
    capitaine-cursors
    corefonts
    dmenu    
    fzf
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
    polybar
    ripgrep
    scc
    shellcheck
    steam
    strace
    sxhkd
    sxiv
    tree
    unclutter
    unrar
    unzip
    valgrind
    veracrypt
    wget
    woeusb
    xwallpaper
    youtube-dl
    zathura
    zip
    zsh
  ];

  security.sudo = {
    enable = true;
    extraConfig = "%wheel ALL=(ALL) NOPASSWD: ALL";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    # Don't forget to set a password with ‘passwd’.
    users.ryan = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
	"networkmanager"
      ];
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
    #displayManager.startx.enable = true;
    windowManager.bspwm.enable = true;
    autoRepeatDelay = 250;
    autoRepeatInterval = 25;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

