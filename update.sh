#!/usr/bin/env sh

cd "$(dirname "$0")" || exit

git pull origin master || exit
git submodule foreach git pull origin master || exit
sudo nix-collect-garbage --delete-older-than 15d || exit
sudo nixos-rebuild switch --upgrade || exit
