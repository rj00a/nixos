{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    #rev = "2dd4c20f496758fd5c573b275a29178516493921";
    ref = "master";
  };
in {
  imports = [ (import "${home-manager}/nixos") ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
      home.file.".xinitrc".text = "exec bspwm";
      xsession.windowManager.bspwm = {
        enable = true;
        settings = {
          border_width = 2;
          window_gap = 7;
          split_ratio = 0.5;
          borderless_monocle = true;
          gapless_monocle = true;
          single_monocle = true;
          focus_follows_pointer = true;
          remove_disabled_monitors = true;
          history_aware_focus = true;
          pointer_modifier = "mod4";

          normal_border_color = "'#444444'";
          focused_border_color = "'#af5f5f'";
          urgent_border_color = "'#bd2c40'";
        };
        startupPrograms = [ "xwallpaper --zoom /etc/nixos/wallpaper.jpg &" ];
      };
      services = {
        sxhkd = {
          enable = true;
          keybindings = {
            # Restart bspwm
            "super + shift + r" = "bspc wm -r";

            # Log out
            "super + shift + q" = "bspc quit";

            # Run alacritty
            "super + Return" = "alacritty";

            # Volume control
            "XF86Audio{RaiseVolume,LowerVolume,Mute}" =
              "amixer sset 'Master' {4%+,4%-,toggle}";

            # Media Player controls
            "XF86Audio{Play,Pause,Next,Prev}" =
              "playerctl {play,pause,next,previous}";

            # Screen brightness controls
            "XF86{MonBrightnessUp,BrightnessDown}" =
              "sudo xbacklight -{inc,dec} 5";

            # Screenshot controls
            "{_,Shift + }Print" =
              "maim -u -{s,i $(xdotool getactivewindow)} ~/last-screenshot.png";

            # Run dmenu
            "super + d" =
              "dmenu_run -fn Ubuntu-Mono -nb '#121212' -sf '#121212' -sb 'af5f5f' -nf '#af5f5f'";

            # Switch between tiled and monocle layout
            "super + space" = "bspc desktop -l next";

            # Focus the next/previous node in the given direction
            "super + {n,p}" = "bspc node -f {next,prev}.local";

            # Toggle window states from tiled to some other state
            "super + {t,shift + t,s,f}" =
              "bspc node -t ~{tiled,pseudo_tiled,floating,fullscreen}";

            # Focus/move the node in the given direction
            "super + {_,shift + }{h,j,k,l}" =
              "bspc node -{f,s} {west,south,north,east}";

            # Close or kill the current node
            "super + {_,shift + }q" = "bspc node -{c,k}";

            # Swap the current node and the biggest node
            "super + g" = "bspc node -s biggest";

            # Rotate children
            "super + r" =
              "bspc node -f @parent && bspc node -R 90 && bspc node -f last";

            # Focus the older or newer node in the focus history
            "super + {o,i}" =
              "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";

            # Focus or send to the given desktop
            "super + {_,shift + }{1-6}" = "bspc {desktop -f,node -d} '{1-6}'";

            ###########################################################

            # send the newest marked node to the newest preselected node
            "super + y" =
              "bspc node newest.marked.local -n newest.!automatic.local";

            # set the node flags
            "super + ctrl + {m,x,y,z}" =
              "bspc node -g {marked,locked,sticky,private}";

            # focus the node for the given path jump
            "super + {p,b,comma,period}" =
              "bspc node -f @{parent,brother,first,second}";

            # focus the next/previous desktop in the current monitor
            "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";

            # focus the last node/desktop
            "super + {grave,Tab}" = "bspc {node,desktop} -f last";

            # preselect the direction
            "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

            # preselect the ratio
            "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

            # cancel the preselection for the focused node
            "super + ctrl + space" = "bspc node -p cancel";

            # cancel the preselection for the focused desktop
            "super + ctrl + shift + space" =
              "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

            # expand a window by moving one of its sides outward
            "super + alt + {h,j,k,l}" =
              "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

            # contract a window by moving one of its sides inward
            "super + alt + shift + {h,j,k,l}" =
              "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

            # move a floating window
            "super + {Left,Down,Up,Right}" =
              "bspc node -v {-20 0,0 20,0 -20,20 0}";
          };
        };
        polybar = {
          enable = true;
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
              modules-left = "date bspwm title";
              modules-right =
                "cpu memory temperature pulseaudio backlight battery";
              modules-center = "xkeyboard";
              bottom = true;
              background = "\${colors.background}";
              foreground = "\${colors.foreground}";
              module-margin = 2;
              height = 25;
              font-0 = "Consolas:size=11;3";
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
              size = 10;
	    };
	    colors = {
              primary = {
                background = "0x000000";
	        foreground = "0xeaeaea";
	      };
	      cursor = {
                text = "0x000000"; # TODO: try gray?
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
      };
    };
  };
}
