# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ (import submodules/home-manager/nixos) ];

  # Packages I want on all my machines.
  environment = {
    systemPackages = with pkgs; [
      (linuxPackages.perf)
      (python3.withPackages (p: [ p.sympy p.numpy p.matplotlib ]))
      ascii
      audacity
      bitwarden
      colordiff
      corefonts
      discord
      dmenu
      exif
      fd
      ffmpeg
      file
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
      nushell
      obs-studio
      p7zip
      pandoc
      patchelf
      playerctl
      ripgrep
      scc
      shellcheck
      steam-run
      strace
      sxiv
      tealdeer
      traceroute
      trash-cli
      unrar
      unzip
      valgrind
      veracrypt
      wget
      woeusb
      x11_ssh_askpass
      xclip
      xdotool
      xfce.thunar
      youtube-dl
      zathura
      zip
      zoxide
    ];

    etc."resolv.conf".text = ''
      nameserver 1.1.1.1
      nameserver 8.8.8.8
      options edns0
    '';
  };

  # TODO: Emojis are a mix of flat colorless and twitter ones.
  fonts = {
    fonts = with pkgs; [
      ubuntu_font_family
      twitter-color-emoji
      noto-fonts
      #noto-fonts-cjk
      #noto-fonts-extra
    ];
    fontconfig.defaultFonts.emoji = [ "Twitter Color Emoji" ];
    fontDir.enable = true;
  };

  users = {
    defaultUserShell = pkgs.nushell;
    # Don't forget to set a password with ‘passwd’.
    users.ryan = {
      isNormalUser = true;
      # wheel is for sudo.
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  # Make sudo not timeout waiting for a passwd.
  security.sudo.extraConfig = ''
    Defaults passwd_timeout=0
  '';

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

  networking = {
    networkmanager.enable = true;
    #nameservers = [ "1.1.1.1" ];
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    #package = pkgs.nixFlakes;
    autoOptimiseStore = true;
    #extraOptions = ''
    #  experimental-features = nix-command flakes
    #'';
  };

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
    # Swap caps lock and escape
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
    windowManager.bspwm = {
      enable = true;
      sxhkd.configFile = files/sxhkdrc;
    };
    autoRepeatDelay = 250;
    autoRepeatInterval = 25;
  };

  programs = {
    dconf.enable = true; # Required for setting gtk theme in home manager.
    java.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # Home manager stuff
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
      home.file = {
        ".icons/default/index.theme".text = ''
          [Icon Theme]
          Inherits=Numix-Cursor-Light'';

        ".config/nixpkgs/config.nix".text = ''
          { allowUnfree = true; }
        '';

        ".config/Code/User/settings.json".source = files/settings.json;
        ".config/nu/config.toml".source = files/nu-config.toml;
      };
      xsession = {
        pointerCursor = {
          package = pkgs.numix-cursor-theme;
          name = "Numix-Cursor-Light";
        };
      };
      services = {
        polybar = {
          enable = true;
          package = pkgs.polybarFull;
          config = import nix/polybar.nix;
          script = ":"; # TODO: "polybar main &" not running?
        };
        unclutter = {
          enable = true;
          timeout = 5;
        };
        network-manager-applet.enable = true;
      };
      programs = {
        git = {
          enable = true;
          userName = "Ryan Johnson";
          userEmail = "ryanj00a@gmail.com";
          delta.enable = true;
          extraConfig = {
            pull.ff = "only";
            init.defaultBranch = "main";
          };
        };
        alacritty = {
          enable = true;
          settings = {
            font = {
              normal.family = "Ubuntu Mono";
              size = 12;
            };
            colors = {
              primary = {
                background = "0x000000";
                foreground = "0xeaeaea";
              };
              cursor = {
                text = "0x000000";
                cursor = "0x00ff00";
              };
              normal = {
                black = "0x000000";
                red = "0xaa0000";
                green = "0x00aa00";
                yellow = "0xaa5500";
                blue = "0x0000aa";
                magenta = "0xaa00aa";
                cyan = "0x00aaaa";
                white = "0xaaaaaa";
              };
              bright = {
                black = "0x555555";
                red = "0xff5555";
                green = "0x55ff55";
                yellow = "0xffff55";
                blue = "0x5555ff";
                magenta = "0xff55ff";
                cyan = "0x55ffff";
                white = "0xffffff";
              };
            };
          };
        };
        chromium.enable = true;
        htop = {
          enable = true;
          settings = {
            hide_threads = true;
            hide_userland_threads = true;
            highlight_base_name = true;
            show_program_path = false;
          };
        };
        fzf.enable = true;
        mpv = {
          enable = true;
          config = {
            profile = "gpu-hq";
            ytdl-format = "bestvideo+bestaudio";
          };
        };
        neovim = {
          enable = true;
          plugins = with pkgs.vimPlugins;
            with pkgs.vimUtils; [
              matchit-zip
              nerdtree
              vim-airline
              vim-airline-themes
              vim-floaterm
              vim-polyglot
              vim-surround
              fzf-vim
              (buildVimPlugin {
                pname = "alduin";
                version = "1.0.0";
                src = files/alduin;
              })
              (buildVimPlugin {
                pname = "searchindex";
                version = "1.0.0";
                src = submodules/vim-searchindex;
              })
              (buildVimPlugin {
                pname = "bbye";
                version = "1.0.0";
                src = submodules/vim-bbye;
              })
            ];
          extraConfig = builtins.readFile files/init.vim;
          vimAlias = true;
        };
      };
      gtk = {
        enable = true;
        theme = {
          package = pkgs.arc-theme;
          name = "Arc-Dark";
        };
        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };
      };
      xresources.properties."Sxiv.background" = "#000000";
    };
  };
}

