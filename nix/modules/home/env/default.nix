{ config, pkgs, lib, ... }: {
  # Session variables
  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
    DOCKER_HOST="unix://${config.home.homeDirectory}/.colima/default/docker.sock";
  };
}