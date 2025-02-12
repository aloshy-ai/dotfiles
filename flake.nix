{
  description = "aloshy.🅰🅸 | dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    snowfall-lib = {
        url = "github:snowfallorg/lib";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-flake = {
        url = "github:snowfallorg/flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
        url = "github:LnL7/nix-darwin/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ci-detector = {
        url = "github:loophp/ci-detector";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
        url = "github:zhaofengli-wip/nix-homebrew";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
          url = "github:hraban/mac-app-util";
          inputs.nixpkgs.follows = "nixpkgs";
        };
  };

  outputs = inputs:
  let
        lib = inputs.snowfall-lib.mkLib {
            inherit inputs;
            src = ./.;

              snowfall = {
                  root = ./nix;
                  #namespace = "aloshy-ai";

                  meta = {
                      name = "dotfiles";
                      title = "dotfiles";
                  };
            };
        };
    in
      lib.mkFlake {
        channels-config = {
                            allowUnfree = true;
                          };
        # Add overlays for the `nixpkgs` channel.
        overlays = with inputs; [
          snowfall-flake.overlays."package/flake"
        ];

        # Add modules to all Darwin systems.
        systems.modules.darwin = with inputs; [
            nix-homebrew.darwinModules.nix-homebrew
            mac-app-util.darwinModules.default
        ];
      };
  }