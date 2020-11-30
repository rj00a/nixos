My personal nixos configuration.

## Installation
- Clone git repo and `git submodule update --init --recursive`
- `chown -R $USER /etc/nixos/`
- `passwd $USER`
- Make `configuration.nix` and `hardware-configuration.nix` symlinks to the appropriate files in `machines/`
- Note: When using `nixos-install`, make sure you add the unstable channel
