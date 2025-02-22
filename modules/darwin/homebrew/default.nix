{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      "nvm"
      "colima"
    ];

    casks = [
      "cursor"
      "webstorm"
      "tailscale"
      "claude"
      "karabiner-elements"
      "docker"
      "opera"
    ];

    # taps = [
    #   "homebrew/services"
    # ];

    masApps = {
      "CopyClip" = 595191960;
      "WireGuard" = 1451685025;
      "DisplayMyIP" = 1493408723;
    };
  };
}
