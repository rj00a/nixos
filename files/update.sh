#!/usr/bin/env sh

set -e

cd "$(dirname "$0")"

sudo nix-collect-garbage --delete-older-than 7d
sudo nix-store --optimise

nix-channel --update
cd ..
git pull origin master
git submodule foreach git pull origin master
sudo nixos-rebuild switch --upgrade
tldr --update &
rustup update
trash-empty -f

# Hack to fix the mouse.
xinput --set-prop 'Logitech G502 HERO Gaming Mouse' 'libinput Accel Speed' -0.3 &

