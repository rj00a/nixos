# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    zsh
    ghc
    shellcheck
    pandoc
    unclutter
    ascii
    zip
    fzf
    steam
    gperf
    htop
    jq
    krita
    maim
    sxiv
    zathura
    ncdu
    neofetch
    polybar
    ripgrep
    scc
    steam
    strace
    sxhkd
    tree
    unrar
    unzip
    valgrind
    veracrypt
    woeusb
    youtube-dl
    audacity
    git
    bitwarden
    stow
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:swapescape";
    libinput.enable = true; # Touchpad support
    windowManager.bspwm.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    # Don't forget to set a password with ‘passwd’.
    users.ryan = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

