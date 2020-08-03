{ config, pkgs, ... }:

{
  imports = [ (import submodules/home-manager/nixos) ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
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
              module-margin = 2;
              height = 25;
              font-0 = "Noto Sans:size=11;3";
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
              # TODO: make this not hardcoded
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
        };
        alacritty = {
          enable = true;
          settings = {
            font = {
              normal.family = "Consolas";
              size = 9;
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
        chromium = {
          enable = true;
          #extensions = [
          #  "ajopnjidmegmdimjlfnijceegpefgped" # BetterTTV
          #  "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # Google Docs Offline
          #  "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
          #  "chphlpgkkbolifaimnlloiipkdnihall" # OneTab
          #  "oeehccpigolildhagkmlpofjplfajiam" # Reddit Comments for YouTube
          #  "kbmfpngjjgdllneeigpgjifpgocmfgmb" # Reddit Enhancement Suite
          #  "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
          #  "pgdnlhfefecpicbbihgmbmffkjpaplco" # uBlock Origin Extra
          #  "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
          #];
        };
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
	mpv = { #TODO
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
            plugins = [
              "aws"
              "cargo"
              "colored-man-pages"
              "common-aliases"
              "git"
              "ripgrep"
              "rsync"
              "rust"
              "rustup"
              "sbt"
              "scala"
              "screen"
            ];
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
      };
    };
  };
}
