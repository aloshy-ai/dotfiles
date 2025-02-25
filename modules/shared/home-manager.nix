{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "aloshy.🅰🅸";
  user = "aloshy";
  email = "noreply@aloshy.ai";
in {
  zsh = {
    enable = true;
    autocd = false;
    cdpath = ["~/.local/share/src"];
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

  alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerd Font Med";
        bold.family = "FiraCode Nerd Font Bold";
        size = 14.0;
      };
    };
  };

  starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[](#9A348E)"
        "$os"
        "$username"
        "[](bg:#DA627D fg:#9A348E)"
        "$directory"
        "[](fg:#DA627D bg:#FCA17D)"
        "$git_branch"
        "$git_status"
        "[](fg:#FCA17D bg:#86BBD8)"
        "$c"
        "$elixir"
        "$elm"
        "$golang"
        "$gradle"
        "$haskell"
        "$java"
        "$julia"
        "$nodejs"
        "$nim"
        "$rust"
        "$scala"
        "[](fg:#86BBD8 bg:#06969A)"
        "$docker_context"
        "[](fg:#06969A bg:#33658A)"
        "$time"
        "[ ](fg:#33658A)"
      ];

      username = {
        show_always = true;
        style_user = "bg:#9A348E";
        style_root = "bg:#9A348E";
        format = "[$user ]($style)";
        disabled = false;
      };

      os = {
        style = "bg:#9A348E";
        disabled = true;
      };

      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      c = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bg:#06969A";
        format = "[ $symbol $context ]($style)";
      };

      elixir = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      elm = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#FCA17D";
        format = "[$all_status$ahead_behind ]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      gradle = {
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      haskell = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      julia = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      nim = {
        symbol = "󰆥 ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      scala = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#33658A";
        format = "[ ♥ $time ]($style)";
      };
    };
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
      "RainbowBrackets.colorMode" = "Consecutive";
      "RainbowBrackets.depreciation-notice" = false;
      "breadcrumbs.enabled" = false;
      "cursor.aipreview.enabled" = true;
      "cursor.cmdk.useThemedDiffBackground" = true;
      "cursor.cpp.enablePartialAccepts" = true;
      "editor.action.moveLinesDownAction" = "shift+cmd+down";
      "editor.action.moveLinesUpAction" = "shift+cmd+up";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.folding" = true;
      "editor.fontFamily" = "'FiraCode Nerd Font'";
      "editor.formatOnSave" = true;
      "editor.semanticHighlighting.enabled" = true;
      "files.autoSave" = "afterDelay";
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.smartCommitChanges" = "all";
      "githubLocalActions.dockerDesktopPath" = "/Applications/Docker.app";
      "programs.vscode.mutableExtensionsDir" = true;
      "security.workspace.trust.banner" = "always";
      "workbench.activityBar.orientation" = "vertical";
      "workbench.sideBar.location" = "left";
      "workbench.tree.enableStickyScroll" = false;
      "workbench.tree.indent" = 16;
      "workbench.tree.renderIndentGuides" = "always";
      "workbench.colorTheme" = "GitHub Dark";
    };
  };

  git = {
    enable = true;
    ignores = ["*.swp"];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nano";
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
    plugins = with pkgs.vimPlugins; [vim-airline vim-airline-themes vim-startify];
    settings = {ignorecase = true;};
  };

  ssh = {
    enable = true;
    includes = [
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (
            lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };
}
