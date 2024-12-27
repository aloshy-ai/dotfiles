{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    ...
  }: let
    username = "aloshy"; # TODO: replace with your username (Command: `whoami`)
    useremail = "noreply@aloshy.ai"; # TODO: replace with your email (Command: `email=$(git config user.email || defaults read MobileMeAccounts | grep -oE 'AccountID = "[^"]+"' | cut -d'"' -f2); while ! nix-shell -p python312Packages.pyisemail --run "python3 -c 'from pyisemail import is_email; print(is_email(\"$email\"))'" | grep -q "True"; do read -p "Enter a valid email: " email; done; echo $email`)
    system = "aarch64-darwin"; # TODO: replace with your system (Command: `uname -m | sed 's/arm64/aarch64-darwin/;s/x86_64/x86_64-darwin/'`)
    hostname = "ETHERFORGE"; # TODO: replace with your hostname. Set the same hostname in `.config/yadm/bootstrap.d/setup-darwin` too. (Command: `scutil --get LocalHostName`)

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix
      ];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
