# Dotfiles

This project is to make my development machine configuration declarative. Ideally, this should run on a fresh Mac, right after first login.

## Prerequisits

1. Install **Homebrew**

    ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. Clone this repo

    ```zsh
    git clone https://github.com/aloshy-ai/dotfiles.git ~
    ```

## Setup **Dotfiles**

1. Install **Stow**

    ```zsh
    brew install stow
    ```

2. Generate `~/.config` symlinks from `~/dotfiles` using the following command:

    ```zsh
    cd ~/dotfiles && stow .
    ```

## Setup **Nix Darwin**

1. Install **Nix**

    Run this command, and follow the instructions

    ```zsh
    sh <(curl -L https://nixos.org/nix/install)
    ```

    Open a new terminal after installation and run the following command to test it.

    ```zsh
    nix-shell -p nix-info --run "nix-info -m"
    ```

2. Complete **TODO**s

    Use the following command to list all `TODO`s and the respective files. Complete them before proceeding to next step.

    ```zsh
    grep -r TODO ~/dotfiles/nix-darwin/*
    ```

3. Stage changes on Git

   This is important to prevent Not Found error in later steps

   ```zsh
   cd ~/dotfiles
   git add .
   ```

4. Backup Shell Configs

    ```zsh
    sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin && sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
    ```

5. Install **Nix Darwin**

    ```zsh
    nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake "$(readlink -f ~/.config/nix-darwin)"
    ```

6. Rebuild **Nix** with **Darwin**

    Open a new terminal and run the following command:

    ```zsh
    darwin-rebuild switch --flake "$(readlink -f ~/.config/nix-darwin)"
    ```
