#!/usr/bin/env sh

cd "$(dirname "$0")" || exit

git pull origin master || exit
git submodule foreach git pull origin master || exit
sudo nixos-rebuild switch --upgrade || exit
