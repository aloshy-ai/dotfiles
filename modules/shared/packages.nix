{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
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
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

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
  hunspell
  iftop
  jetbrains-mono
  jq
  tree
  unrar
  unzip
  zsh-powerlevel10k

  # Python packages
  python3
  virtualenv
]
