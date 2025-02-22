{ config, pkgs, lib, ... }:

let name = "aloshy.🅰🅸";
    user = "aloshy";
    email = "noreply@aloshy.ai"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    plugins = [];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.local/share/bin:$PATH

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Always color ls and group directories
      alias ls='ls --color=auto'

      # ASCII Art 
      neofetch --ascii "$(curl -fsSL https://ascii.aloshy.ai | sh)"  --color_blocks off --disable kernel uptime packages shell de wm wm_theme resolution gpu memory term term_font theme model cpu
    '';
  };

  starship = {
    enable = true;
    enableZshIntegration = true;
  };

  vscode = {
          enable = true;
          package = pkgs.vscode;
          mutableExtensionsDir = true;
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            github.vscode-github-actions
            github.copilot
            github.copilot-chat
            github.codespaces
            github.github-vscode-theme
            github.vscode-pull-request-github
            esbenp.prettier-vscode
          ];
          userSettings = {
            "editor.fontFamily" = "'FiraCode Nerd Font'";
            "editor.folding" = true;
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.semanticHighlighting.enabled" = true;
            "editor.formatOnSave" = true;
            "editor.action.moveLinesDownAction" = "shift+cmd+down";
            "editor.action.moveLinesUpAction" = "shift+cmd+up";
            "files.autoSave" = "afterDelay";
            "RainbowBrackets.depreciation-notice" = false;
            "RainbowBrackets.colorMode" = "Consecutive";
            "breadcrumbs.enabled" = false;
            "workbench.tree.enableStickyScroll" = false;
            "workbench.tree.indent" = 12;
            "workbench.tree.renderIndentGuides" = "always";
            "workbench.sideBar.location" = "left";
            "git.autofetch" = true;
            "git.enableSmartCommit" = true;
            "git.confirmSync" = false;
            "git.smartCommitChanges" = "all";
            "cursor.aipreview.enabled" = true;
            "cursor.cmdk.useThemedDiffBackground" = true;
            "cursor.cpp.enablePartialAccepts" = true;
          };
        };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = false;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  gh = {
    enable = true;
  };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify ];
    settings = { ignorecase = true; };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };
}
