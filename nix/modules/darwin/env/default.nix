{ pkgs, ... }: {

  # System level Environment variables on all systems.
  environment = {
    variables = {
      SHELL = "zsh";
      EDITOR = "nano";
    };
  };
}
