PROMPT="%F{7}[%f%F{14}%n%f%b@%F{13}%m%f %F{7}%~%f%(?.. %F{9}%?%f)%F{7}]%f "

# Expand command aliases with tab
zstyle ':completion:*' completer _expand_alias _complete _ignored

export VISUAL=nvim
export EDITOR=nvim
export BROWSER=chromium

# Download here instead of ~/Downloads
export XDG_DOWNLOAD_DIR=~/dl/

# Make fzf use fd instead of find
# fd ignores .git and stuff in .gitignore by default
export FZF_DEFAULT_COMMAND fd

# Make python write .pyc files here instead of the cwd
export PYTHONCACHEPREFIX=~/.cache/cpython/

# Timezone for `date`
export TZ=America/Los_Angeles

# Fixes a bad interaction between intellij and bspwm
export _JAVA_AWT_WM_NONREPARENTING=1

unset GIT_ASKPASS
unset SSH_ASKPASS

alias ls='ls -A --color=auto --group-directories-first'
alias la='ls -lAiFh --color=auto --group-directories-first'

alias diff=colordiff

alias tree='tree -C'

# Don't cache opened images
alias sxiv='sxiv -p'

# Download video and audio at the highest quality
alias dlv='youtube-dl -iwcR infinite --add-metadata'
alias dla='youtube-dl -xwicR infinite -f bestaudio --audio-quality 0 --add-metadata'

# For the trash-cli program
alias tra=trash
alias tra-empty=trash-empty
alias tra-list=trash-list
alias tra-put=trash-put
alias tra-restore=trash-restore
alias tra-rm=trash-rm

# Prompt before overwrite
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias update='/etc/nixos/update.sh'
alias collect-garbage='/etc/nixos/collect-garbage.sh'

alias backup='/etc/nixos/backup.sh'

alias code-stdenv="nix-shell -E '(import <nixpkgs> {}).stdenv.mkDerivation { name = \"code-env\"; }' --run code"

ccd() {
  mkdir -p $1 && cd $1
}

em() {
  local res="$(fzf < /etc/nixos/files/emojis.txt)"
  if [ "$res" ]; then
    printf '%s' "$(echo "$res" | cut -f 1 -d ' ')" | xclip -selection clipboard
  fi
}


play() {
  local file="$(find /mnt/bulk/{music,films}/ -type f 2> /dev/null | fzf)"
  if [ -n "$file" ]; then
    mpv --player-operation-mode=pseudo-gui "$file" &
    disown
    exit 0
  fi
}

playa() {
  local dir="$(find /mnt/bulk/music/ -type d 2> /dev/null | fzf)"
  if [ "$dir" ]; then
    local trax="$(python -B /etc/nixos/files/trackord.py "$dir"/*)"
    if [ "$trax" ]; then
      mpv --player-operation-mode=pseudo-gui ${(f)trax} &
      disown
      exit 0
    fi
  fi
}

playshuf() {
  local dir="$(find /mnt/bulk/music/ -type d 2> /dev/null | fzf)"
  if [ "$dir" ]; then
    local trax=$(shuf -e "$dir"/*)
    mpv --player-operation-mode=pseudo-gui ${(f)trax} &
    disown
    exit 0
  fi
}

