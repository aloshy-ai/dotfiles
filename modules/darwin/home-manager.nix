{ config, pkgs, lib, home-manager, mac-app-util, ... }:

let
  user = "aloshy";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
   ./homebrew
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Enable home-manager
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];
        sessionVariables = {
          DIRENV_LOG_FORMAT = "";
          DOCKER_HOST = "unix:///$HOME/.colima/docker.sock";
        };

        stateVersion = "23.11";
      };
      programs = {
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
            "window.zoomLevel" = 0.8;
            "editor.fontSize" = 14;
            "editor.tabSize" = 4;
            "editor.fontFamily" = "'FiraCode Nerd Font'";
            "editor.folding" = true;
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.lineHeight" = 22;
            "editor.fontWeight" = "400";
            "editor.semanticHighlighting.enabled" = true;
            "editor.formatOnSave" = true;
            "files.autoSave" = "afterDelay";
            "cursor.aipreview.enabled" = true;
            "cursor.cmdk.useThemedDiffBackground" = true;
            "cursor.cpp.enablePartialAccepts" = true;
            "terminal.integrated.fontSize" = 14;
            "RainbowBrackets.depreciation-notice" = false;
            "RainbowBrackets.colorMode" = "Consecutive";
            "breadcrumbs.enabled" = false;
            "workbench.tree.enableStickyScroll" = false;
            "workbench.tree.indent" = 14;
            "workbench.tree.renderIndentGuides" = "always";
            "workbench.sideBar.location" = "left";
            "workbench.colorCustomizations" = {
              "activityBar.background" = "#282c34";
              "sideBar.background" = "#282c34";
              "tab.activeBackground" = "#282c34";
              "editor.background" = "#1e1e1e";
              "editor.foreground" = "#d4d4d4";
              "editorIndentGuide.background1" = "#404040";
              "editorRuler.foreground" = "#333333";
              "activityBarBadge.background" = "#007acc";
              "sideBarTitle.foreground" = "#bbbbbb";
            };
            "git.autofetch" = true;
            "git.enableSmartCommit" = true;
            "git.confirmSync" = false;
            "git.smartCommitChanges" = "all";
          };
        };
      } // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = { 
    dock = {
      enable = true;
      entries = [
        # I like it empty!
        # { path = "/System/Applications/Music.app/"; }
      ];
    };
  };
}
