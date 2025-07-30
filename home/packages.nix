{ lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = { style = "plain"; };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Save history in a sqlite database
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      compact = "compact";
      enter_accept = "true"; # immediately executing a command
      auto_sync = true;
      sync_frequency = "5m";
      workspaces = true;
      update_check = false;
      history_filter = [ "^.." "^cd " "^ls" "cd" "exit" ":q" ];
    };
    flags = [ "--disable-up-arrow" ];
  };

  # Improved ls tool
  programs.lsd.enable = true;
  programs.lsd.settings = {
    date = "relative";
    ignore-globs = [ ".git" ".hg" ];
  };

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.btop.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.less.enable = true;
  programs.ripgrep.enable = true;
  programs.tealdeer.enable = true;
  programs.jq.enable = true;

  programs.k9s = {
    enable = true;
    skins = { default = { k9s = { body = { fgColor = "dodgerblue"; }; }; }; };
    views = {
      # Move all nested views directly under programs.k9s.views
      "v1/pods" = {
        columns = [ "AGE" "NAMESPACE" "NAME" "IP" "NODE" "STATUS" "READY" ];
      };
    };
    plugins = {
      # Renamed from plugin to plugins
      fred = {
        shortCut = "Ctrl-L";
        description = "Pod logs";
        scopes = [ "po" ];
        command = "kubectl";
        background = false;
        args = [ "logs" "-f" "$NAME" "-n" "$NAMESPACE" "--context" "$CLUSTER" ];
      };
    };
  };

  # SSH
  # https://nix-community.github.io/home-manager/options.html#opt-programs.ssh.enable
  # Some options also set in `../darwin/homebrew.nix`.
  programs.ssh.enable = true;
  # ensures the path is unique but also fixed length
  programs.ssh.controlPath = "~/.ssh/%C";

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  home.packages = lib.attrValues ({
    supabase-cli = pkgs.callPackage ./supabase-cli.nix { };

    # Some cli basics
    inherit (pkgs)
      bandwhich # display current network utilization by process
      coreutils # The GNU Core Utilities
      curl # Transferring files with URL syntax
      du-dust # fancy version of `du`
      fd # fancy version of `find`
      mdcat # display mardown files
      mosh # wrapper for `ssh` that better and not dropping connections
      unrar # extract RAR archives
      upterm # secure terminal sharing
      wget # Stable wget instead of wget2 (build issues)
      xz # extract XZ archives
    ;

    # Dev stuff
    inherit (pkgs)
      cloc # source code line counter
      gh-copilot # GitHub Copilot CLI
      nodejs # Node.js runtime
      s3cmd # command line tool for managing Amazon S3 and CloudFront
      typescript # TypeScript compiler
      yq # command-line YAML processor, similar to jq
      shfmt # shell script formatter
      colima # container runtime with support for Docker and Kubernetes
      docker # container runtime
      biome # JavaScript and TypeScript linter, formatter, and bundler
      firebase-tools # command line tools for Firebase
      docker-compose # tool for defining and running multi-container Docker applications
    ;

    # Kubernetes stuff
    inherit (pkgs)
      kustomize # tool for customizing Kubernetes YAML configurations
      kubernetes-helm # Helm package manager for Kubernetes
      kubectl # command line tool for interacting with Kubernetes clusters
      kubectx # switch between Kubernetes clusters easily
    ;

    # Useful nix related tools
    inherit (pkgs)
      cachix # adding/managing alternative binary caches hosted by Cachix
      comma # run software from without installing it
      nix-output-monitor # get additional information while building packages
      nix-tree # interactively browse dependency graphs of Nix derivations
      nix-update # swiss-knife for updating nix packages
      nixpkgs-review # review pull-requests on nixpkgs
      node2nix # generate Nix expressions to build NPM packages
      statix # lints and suggestions for the Nix programming language
    ;

    # AI tools
    inherit (pkgs)
      ollama # run and manage large language models locally
      gemini-cli # Google Gemini CLI
      gpt-cli # CLI für ChatGPT, Claude und Bard
      code-cursor # AI-powered code completion and navigation
      claude-code # CLI for Anthropic's Claude AI
    ;

  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    inherit (pkgs) m-cli # useful macOS CLI commands
    ;
  });
}
