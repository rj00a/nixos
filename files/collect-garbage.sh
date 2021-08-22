#!/usr/bin/env sh

set -e

sudo nix-collect-garbage --delete-older-than 7d
sudo nix optimise-store
trash-empty
