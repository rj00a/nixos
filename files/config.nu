# ======== CUSTOM STUFF ======== #

let-env config {
    # Disable welcome message
    show_banner: false
}

# Load zoxide
source /etc/nixos/files/.zoxide.nu

let-env VISUAL = 'nvim'
let-env EDITOR = 'nvim'
let-env BROWSER = 'chromium'

# Download here instead of the usual ~/Downloads
let-env XDG_DOWNLOAD_DIR = '~/dl/'

# Make fzf use fd instead of find
let-env FZF_DEFAULT_COMMAND = 'fd'

# Make python write .pyc files here instead of the cwd
let-env PYTHONCACHEPREFIX = '~/.cache/cpython/'

# Timezone for local date command
let-env TZ = 'America/Los_Angeles'

# Fixes a bad interaction between intellij and bspwm
let-env _JAVA_AWT_WM_NONREPARENTING = '1'

# Java doesn't use antialiasing by default
let-env _JAVA_OPTIONS = '-Dawt.useSystemAAFontSettings=lcd'

# Don't cache opened images
alias sxiv = sxiv -p

# Download video and audio at the highest quality
alias dlv = youtube-dl -iwcR infinite --add-metadata
alias dla = youtube-dl -xwicR infinite -f bestaudio --audio-quality 0 --add-metadata

alias update = bash /etc/nixos/files/update.sh
alias backup = bash /etc/nixos/files/backup.sh

alias cls = clear

# Delete to trash
alias rm = rm -t

# Also show hidden files.
alias ls = ls -a

# TODO: ccd replacement.

# NUSHELL 0.4 CONFIG:
#
# echo # prompt bug workaround
# zoxide init nushell --hook prompt | save ~/.zoxide.nu
# source ~/.zoxide.nu
# 
# let-env VISUAL = nvim
# let-env EDITOR = nvim
# let-env BROWSER = chromium
# 
# # Download here instead of the usual ~/Downloads
# let-env XDG_DOWNLOAD_DIR = ~/dl/
# 
# # Make fzf use fd instead of find
# let-env FZF_DEFAULT_COMMAND = fd
# 
# # Make python write .pyc files here instead of the cwd
# let-env PYTHONCACHEPREFIX = ~/.cache/cpython/
# 
# # Timezone for local date command
# let-env TZ = America/Los_Angeles
# 
# # Fixes a bad interaction between intellij and bspwm
# let-env _JAVA_AWT_WM_NONREPARENTING = "1"
# 
# # Java doesn't use antialiasing by default
# let-env _JAVA_OPTIONS = '-Dawt.useSystemAAFontSettings=lcd'
# 
# # Don't cache opened images
# alias sxiv = sxiv -p
# 
# # Download video and audio at the highest quality
# alias dlv = 'youtube-dl -iwcR infinite --add-metadata'
# alias dla = 'youtube-dl -xwicR infinite -f bestaudio --audio-quality 0 --add-metadata'
# 
# alias update = bash /etc/nixos/files/update.sh
# alias backup = bash /etc/nixos/files/backup.sh
# 
# alias cls = clear
# 
# alias stdenv = nix-shell -E '
# with import <nixpkgs> {};
# stdenv.mkDerivation {
#   name = "stdenv";
#   buildInputs = [
#     pkg-config
#     openssl
#     libxkbcommon
#     xorg.libX11
#     xorg.libXcursor
#     xorg.libXi
#     xorg.libXrandr
#     xorg.libxcb
#   ];
# }'
# 
# #alias code-stdenv = nix-shell -E '
# #with import <nixpkgs> {};
# #stdenv.mkDerivation {
# #  name = "stdenv";
# #  buildInputs = [pkg-config openssl];
# #}' --run "code ."
# 
# # Nushell's cp rm and mv don't prompt before being destructive so let's use the system commands for now.
# # Also, nushell's trash functionality appears to be broken.
# alias rm = ^rm -i
# alias cp = ^cp -i
# alias mv = ^mv -i
# 
# # Create a directory and immediately cd into it.
# def ccd [dir: path] {
#   cd (mkdir -s $dir)
# }
# 
# # Search for an emoji and copy it to the clipboard.
# def emoji [] {
#   let text = (open --raw /etc/nixos/files/emojis.txt | fzf)
#   if $text != '' {
#     # `clip` command didn't work :(
#     echo $text | split column ' ' | get Column1 | xclip -selection clipboard
#   } {}
# }
# 
# # TODO: need a way to detach processes so the stuff below can be done without bash.
# 
# # Search for a song or film to play with mpv
# def play [] {
#   bash -c '
#     file="$(find /mnt/bulk/{music,films}/ -type f 2> /dev/null | fzf)"
#     if [ -n "$file" ]; then
#       nohup mpv --player-operation-mode=pseudo-gui --keep-open=yes "$file" >/dev/null 2>&1 &
#       disown
#     fi
#   '
#   exit
# }
# 
# # Search for a directory to play the contents of in album order.
# def playa [] {
#   bash -c '
#     dir="$(find /mnt/bulk/music/ -type d 2> /dev/null | fzf)"
#     if [ "$dir" ]; then
#       trax="$(python -B /etc/nixos/files/trackord.py "$dir"/*)"
#       if [ "$trax" ]; then
#         set -f
#         IFS="
# "
#         nohup mpv --player-operation-mode=pseudo-gui --keep-open=yes $trax >/dev/null 2>&1 &
#         disown
#       fi
#     fi
#   '
#   exit
# }
# 
# # Search for a directory to play the contents of randomly.
# def playshuf [] {
#   bash -c '
#     dir="$(find /mnt/bulk/music/ -type d 2> /dev/null | fzf)"
#     if [ "$dir" ]; then
#       trax=$(shuf -e "$dir"/*)
#       set -f
#       IFS="
# "
#       nohup mpv --player-operation-mode=pseudo-gui ${trax[@]} >/dev/null 2>&1 &
#       disown
#     fi
#   '
#   exit
# }
