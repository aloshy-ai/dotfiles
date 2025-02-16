{ pkgs }:

with pkgs; [
  # General packages for development and system management
  bash-completion
  btop
  coreutils-full
  inetutils
  killall
  neofetch
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  yubikey-agent
  age-plugin-yubikey
  gnupg
  libfido2  

  # Media-related packages
  ffmpeg
  font-awesome

  # Nerd fonts
  nerd-fonts.jetbrains-mono
  nerd-fonts.symbols-only
  nerd-fonts.fira-code
  nerd-fonts.sauce-code-pro
  nerd-fonts.roboto-mono
  nerd-fonts.iosevka
  nerd-fonts.droid-sans-mono

  # Development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs
  devbox
  act
  docker
  docker-compose
  docker-credential-helpers

  # Text and terminal utilities
  htop
  jq
  tree
  unrar
  unzip

  # Python packages
  python3
  virtualenv
]
