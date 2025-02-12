{ pkgs, ...}: {

    imports = [
        ./home-manager.nix
        ./direnv.nix
        ./gh.nix
        ./starship.nix
        ./vscode.nix
        ./zsh.nix
        ./git.nix
    ];

    home.packages = with pkgs; [
        devbox
        colima
        docker
        act
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];
}