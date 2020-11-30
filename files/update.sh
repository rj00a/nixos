#!/usr/bin/env sh

set -e

cd "$(dirname "$0")"

tldr --update &
cd ..
git pull origin master
git submodule foreach git pull origin master
sudo nixos-rebuild switch --upgrade

