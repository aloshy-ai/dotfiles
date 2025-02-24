{
  agenix,
  config,
  pkgs,
  ...
}: let
  user = "aloshy";
in {
  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    agenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      # user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = x86_64-linux aarch64-linux
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment = {
    systemPackages = with pkgs;
      [
        agenix.packages."${pkgs.system}".default
      ]
      ++ (import ../../modules/shared/packages.nix {inherit pkgs;});
    variables = {
    };
  };

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "right";
        tilesize = 24;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  nix.linux-builder = {
    enable = true;
    maxJobs = 4; # Adjust based on your CPU

    # Support both major architectures
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    # Add any needed features
    supportedFeatures = [
      "kvm"
      "benchmark"
      "big-parallel"
    ];
  };

  # Nix will perform derivations on those machines via SSH by copying the inputs to the Nix store on the remote machine, starting the build, then copying the output back to the local Nix store.
  # nix.distributedBuilds = true;

  # nix.buildMachines = [
  #   {
  #     hostName = "localhost";
  #     systems = ["x86_64-darwin"];
  #     maxJobs = 4;
  #     supportedFeatures = ["benchmark" "big-parallel"];
  #   }
  # ];
}
