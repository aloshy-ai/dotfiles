{ ... }: {
  programs = {
    zsh = {
      enable = true;
      initExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
        eval "$(devbox global shellenv)"
        refresh-global
      '';
    };
  };
}
