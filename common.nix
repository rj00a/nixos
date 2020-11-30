# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

#let pkgs = import submodules/nixpkgs/nixos {}; in

{
  imports = [ (import submodules/home-manager/nixos) ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      ascii
      audacity
      bitwarden
      cargo
      colordiff
      corefonts
      discord
      dmenu
      exif
      fd
      ffmpeg
      file
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
      rustc
      rustfmt
      scc
      shellcheck
      strace
      sxiv
      tealdeer
      traceroute
      trash-cli
      tree
      unrar
      unzip
      valgrind
      veracrypt
      wget
      woeusb
      x11_ssh_askpass
      xclip
      xfce.thunar
      youtube-dl
      zathura
      zip
      zsh
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
    ];
    fontconfig.defaultFonts.emoji = [ "Twitter Color Emoji" ];
    fontDir.enable = true;
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

  networking.networkmanager.enable = true;

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

  programs.dconf.enable =
    true; # Required for setting gtk theme in home manager.

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

        ".config/Code/User/keybindings.json".source = files/keybindings.json;
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
          config = {
            colors = {
              background = "#121212";
              foreground = "#dfdfdf";
              foreground-alt = "#444444";
              yellowish = "#dfdfaf";
              reddish = "#af5f5f";
              alert = "#bd2c40";
            };
            "bar/main" = {
              modules-left = "date title";
              modules-right =
                "cpu memory temperature pulseaudio backlight battery";
              modules-center = "xkeyboard";
              bottom = true;
              background = "\${colors.background}";
              foreground = "\${colors.foreground}";
              height = 20;
              font-0 = "Noto Sans:pixelsize=11;4";
              font-1 = "Ubuntu Mono:pixelsize=11;4";
              font-2 = "Consolas:pixelsize=11;4";
              module-margin = 2;
              padding-left = 2;
              padding-right = 2;
              tray-position = "left";
              tray-padding = 2;
              cursor-click = "pointer";
              scroll-up = "bspwm-desknext";
              scroll-down = "bspwm-deskprev";
            };
            "module/xkeyboard" = {
              type = "internal/xkeyboard";
              blacklist-0 = "num lock";
              blacklist-1 = "scroll lock";
              format = "<label-indicator>";
            };
            "module/title" = {
              type = "internal/xwindow";
              format-foreground = "\${colors.reddish}";
              label-maxlen = 70;
            };
            "module/date" = {
              type = "internal/date";
              date = "%a %b %d";
              time = "%r";
              label = "%date% %time%";
            };
            "module/pulseaudio" = {
              type = "internal/pulseaudio";
              format-volume = "<label-volume> <bar-volume>";
              label-volume = "Vol %percentage%%";
              label-volume-foreground = "\${root.foreground}";
              label-muted = "Vol %percentage%% <muted>";
              label-muted-foreground = "\${colors.foreground-alt}";
              bar-volume-width = 10;
              bar-volume-foreground-0 = "#55aa55";
              bar-volume-foreground-1 = "#55aa55";
              bar-volume-foreground-2 = "#55aa55";
              bar-volume-foreground-3 = "#55aa55";
              bar-volume-foreground-4 = "#55aa55";
              bar-volume-foreground-5 = "#f5a70a";
              bar-volume-foreground-6 = "#ff5555";
              bar-volume-gradient = true;
              bar-volume-indicator = "|";
              bar-volume-indicator-font = 2;
              bar-volume-fill = "─";
              bar-volume-fill-font = 2;
              bar-volume-empty = "─";
              bar-volume-empty-font = 2;
              bar-volume-empty-foreground = "\${colors.foreground-alt}";
            };
            "module/battery" = {
              type = "internal/battery";
              battery = "BAT1";
              adapter = "ACAD";
              label-charging = "Bat ↑ %percentage%%";
              label-discharging = "Bat ↓ %percentage%%";
            };
            "module/cpu" = {
              type = "internal/cpu";
              interval = "0.5";
              label = "Cpu %percentage%%";
              format = "<label>  <ramp-coreload>";
              ramp-coreload-spacing = 1;
              ramp-coreload-0 = "▁";
              ramp-coreload-1 = "▂";
              ramp-coreload-2 = "▃";
              ramp-coreload-3 = "▄";
              ramp-coreload-4 = "▅";
              ramp-coreload-5 = "▆";
              ramp-coreload-6 = "▇";
              ramp-coreload-7 = "█";
            };
            "module/memory" = {
              type = "internal/memory";
              interval = 1;
              format-prefix-foreground = "\${colors.foreground-alt}";
              format-underline = "#4bffdc";
              label =
                "Mem %percentage_used%% %gb_used%    Swp %percentage_swap_used%% %gb_swap_used%";
            };
            "module/temperature" = {
              type = "internal/temperature";
              format = "Tmp <label>";
            };
            "module/xbacklight" = {
              type = "internal/xbacklight";
              format = "<label> <bar>";
              label = "Lgt %percentage%%";
              bar-width = 10;
              bar-indicator = "|";
              bar-indicator-foreground = "#fff";
              bar-indicator-font = 2;
              bar-fill = "─";
              bar-fill-font = 2;
              bar-fill-foreground = "#9f78e1";
              bar-empty = "─";
              bar-empty-font = 2;
              bar-empty-foreground = "\${colors.foreground-alt}";
            };
            "module/backlight" = {
              "inherit" = "module/xbacklight";
              type = "internal/backlight";
              card = "intel_backlight";
            };
          };
          script = "polybar main &";
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
          extraConfig.pull.ff = "only";
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
          hideThreads = true;
          hideUserlandThreads = true;
          highlightBaseName = true;
          showProgramPath = false;
        };
        fzf = {
          enable = true;
          enableZshIntegration = true;
        };
        mpv = {
          enable = true;
          config = {
            profile = "gpu-hq";
            ytdl-format = "bestvideo+bestaudio";
          };
        };
        zsh = {
          enable = true;
          enableAutosuggestions = true;
          enableCompletion = true;
          enableVteIntegration = true;
          autocd = true;
          oh-my-zsh = {
            enable = true;
            plugins = [ "cargo" "colored-man-pages" "ripgrep" "rsync" "rust" ];
          };
          plugins = [
            {
              name = "zsh-syntax-highlighting";
              src = submodules/zsh-syntax-highlighting;
            }
            {
              name = "zsh-z";
              src = submodules/zsh-z;
            }
          ];
          initExtra = builtins.readFile files/init.zsh;
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
                name = "alduin";
                src = files/alduin;
              })
              (buildVimPlugin {
                name = "searchindex";
                src = submodules/vim-searchindex;
              })
              (buildVimPlugin {
                name = "bbye";
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

