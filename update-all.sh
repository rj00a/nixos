#!/usr/bin/env sh

cd "$(dirname "$0")" || exit

git pull --ff-only --recurse-submodules || exit
sudo nix-collect-garbage --delete-older-than 2d || exit
sudo nixos-rebuild switch || exit
