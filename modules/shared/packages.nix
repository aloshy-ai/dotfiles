{ pkgs }:

with pkgs; [
  # General packages for development and system management
  bash-completion
  btop
  coreutils
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

  # Cloud-related tools and SDKs
  docker
  docker-compose

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
