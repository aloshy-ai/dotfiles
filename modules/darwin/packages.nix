{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  utm
  colima
  brave
  freetube
  syncthing
  telegram-desktop
  zoom-us
]
