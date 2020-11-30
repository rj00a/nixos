#!/usr/bin/env sh

sudo nix-collect-garbage --delete-older-than 7d || exit
sudo nix optimise-store || exit
trash-empty
