{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  utm
  brave
  syncthing
  telegram-desktop
  zoom-us
  colima
]
