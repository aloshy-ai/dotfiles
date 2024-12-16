# Uninstall Nix

1. Perform all the steps in [Nix Reference Manual](https://nix.dev/manual/nix/2.17/installation/uninstall).
2. Remove sticky symlink (if exists) by following [this](https://discourse.nixos.org/t/ssl-ca-cert-error-on-macos/31171/4).
3. Find any remaining traces of `nix` using the following command, and remove all unwanted ones.
   `sudo find / -name "nix" -type d 2>/dev/null`
4. Reboot the machine.