{ pkgs, lib, inputs, ... }:
{

nix-homebrew = {
        enable = true;
        user = "aloshy";
        autoMigrate = true;
    };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    masApps = {
      CopyClip = 595191960;
      DisplayMyIp = 1493408723;
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
      "nvm"
    ];

    casks = [
      "opera"
      "docker"
      "cursor"
      "freetube"
    ];
  };
}