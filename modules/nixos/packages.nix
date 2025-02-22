{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages ++ [
    docker-compose
    docker-credential-helpers
  ]
