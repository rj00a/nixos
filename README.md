My personal nixos configuration.

## Installation
* `chown -R $USER /etc/nixos/`
* `passwd $USER`
* Make `configuration.nix` and `hardware-configuration.nix` links to the appropriate files in `machines/`
* Note: When using `nixos-install`, make sure you add the unstable channel
