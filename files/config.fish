
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

# Initialize zoxide
zoxide init fish | source

