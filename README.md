# Dotfiles

This project is to make my development machine configuration declarative. Ideally, this should run on a fresh Mac, right after first login.

## Install
```zsh
sh <(curl -L "https://dotfiles.aloshy.ai")
```

## Pull Changes

```zsh
yadm pull
```

## Apply Changes

```zsh
darwin-rebuild switch --flake ~/.config/nix-darwin
```

