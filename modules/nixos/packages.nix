{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  # App and package management
  appimage-run
  gnumake
  cmake

  # Screenshot and recording tools
  flameshot

  # Text and terminal utilities
  feh # Manage wallpapers
  screenkey
  tree
  unixtools.ifconfig
  unixtools.netstat
  xorg.xwininfo # Provides a cursor to click and learn about windows
  xorg.xrandr

  # File and system utilities
  inotify-tools # inotifywait, inotifywatch - For file system events
  libnotify
  sqlite
  xdg-utils

  # Other utilities
  xdotool
  google-chrome

  # PDF viewer
  zathura

  # Music and entertainment
  spotify
]
