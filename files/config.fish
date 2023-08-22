
# Show the full working directory in the path.
set -gx fish_prompt_pwd_dir_length 0
set fish_greeting

set -gx VISUAL hx
set -gx EDITOR hx
set -gx BROWSER chromium

# Make fzf use fd instead of find
set -gx FZF_DEFAULT_COMMAND 'fd'

# Make python write .pyc files here instead of the cwd
set -gx PYTHONCACHEPREFIX '~/.cache/cpython/'

# Timezone for local date command
set -gx TZ 'America/Los_Angeles'

# Java doesn't use antialiasing by default
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=lcd'

alias ls 'ls -A --group-directories-first --color=always'

alias suspend 'systemctl suspend'
alias hibernate 'systemctl hibernate'

# Don't cache opened images
alias sxiv 'sxiv -p'

# Download video and audio at the highest quality
alias dlv 'youtube-dl -iwcR infinite --add-metadata'
alias dla 'youtube-dl -xwicR infinite -f bestaudio --audio-quality 0 --add-metadata'

alias update 'bash /etc/nixos/files/update.sh'
alias backup 'bash /etc/nixos/files/backup.sh'

alias cls clear

# Nord Theme
$ set -gx fish_color_normal normal
$ set -gx fish_color_command 81a1c1
$ set -gx fish_color_quote a3be8c
$ set -gx fish_color_redirection b48ead
$ set -gx fish_color_end 88c0d0
$ set -gx fish_color_error ebcb8b
$ set -gx fish_color_param eceff4
$ set -gx fish_color_comment 434c5e
$ set -gx fish_color_match --background=brblue
$ set -gx fish_color_selection white --bold --background=brblack
$ set -gx fish_color_search_match bryellow --background=brblack
$ set -gx fish_color_history_current --bold
$ set -gx fish_color_operator 00a6b2
$ set -gx fish_color_escape 00a6b2
$ set -gx fish_color_cwd green
$ set -gx fish_color_cwd_root red
$ set -gx fish_color_valid_path --underline
$ set -gx fish_color_autosuggestion 4c566a
$ set -gx fish_color_user brgreen
$ set -gx fish_color_host normal
$ set -gx fish_color_cancel --reverse
$ set -gx fish_pager_color_prefix normal --bold --underline
$ set -gx fish_pager_color_progress brwhite --background=cyan
$ set -gx fish_pager_color_completion normal
$ set -gx fish_pager_color_description B3A06D
$ set -gx fish_pager_color_selected_background --background=brblack
$ set -gx fish_pager_color_selected_description
$ set -gx fish_color_keyword
$ set -gx fish_color_option
$ set -gx fish_pager_color_secondary_completion
$ set -gx fish_pager_color_secondary_background
$ set -gx fish_color_host_remote
$ set -gx fish_pager_color_secondary_prefix
$ set -gx fish_pager_color_selected_completion
$ set -gx fish_pager_color_background
$ set -gx fish_pager_color_secondary_description
$ set -gx fish_pager_color_selected_prefix

# Initialize zoxide
zoxide init fish | source

