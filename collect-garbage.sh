#!/usr/bin/env sh

sudo nix-collect-garbage --delete-older-than 15d || exit
