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
      delta # A viewer for git and diff output
      direnv # Load and unload environment variables depending on the current directory
      dnsutils # DNS utilities (dig, nslookup)
      du-dust # du-dust, a more intuitive version of du in rust
      eza # A modern replacement for ls
      fd # A simple, fast and user-friendly alternative to find
      gh # Github cli
      git # Distributed version control system
      gnupg # GNU Privacy Guard
      go # The Go programming language
      gum # A tool for glamorous shell scripts
      htop # Interactive process viewer
      httpie # A user-friendly cURL replacement
      jq # A lightweight and flexible command-line JSON processor
      lazygit # A simple terminal UI for git commands
      neofetch # A command-line system information tool
      nix-output-monitor # A tool to monitor nix build output
      nmap # A security scanner
      openssh # An open source version of the SSH protocol suite of network connectivity tools
      p7zip # A file archiver with high compression ratio
      ripgrep # A line-oriented search tool that recursively searches the current directory for a regex pattern
      sd # An intuitive find & replace CLI
      shellcheck # A static analysis tool for shell scripts
      socat # A utility for reading from and writing to network connections
      tealdeer # A very fast implementation of tldr in Rust
      tree # A recursive directory listing command
      unzip # An extraction utility for archives compressed in .zip format
      wget # A utility for non-interactive download of files from the Web
      yq-go # A portable command-line YAML processor
      zoxide # A faster way to navigate your filesystem
      zsh # The Z shell
      ;
  });
}
