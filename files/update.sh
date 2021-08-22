#!/usr/bin/env sh

set -e

cd "$(dirname "$0")"

tldr --update &
nix-channel --update
cd ..
git pull origin master
git submodule foreach git pull origin master
sudo nixos-rebuild switch --upgrade

# Hack to fix the mouse.
xinput --set-prop 'Logitech G502 HERO Gaming Mouse' 'libinput Accel Speed' -0.3 &

