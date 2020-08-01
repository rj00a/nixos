{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "rjlaptop";
}

