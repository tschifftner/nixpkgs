{ lib, pkgs, ... }:

{
  # Import modularized package configurations
  imports = [
    ./packages  # All package modules are now organized in ./packages/
  ];

  # Core program configurations
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
  programs.ssh.settings."*".controlPath = "~/.ssh/%C";
  programs.ssh.enableDefaultConfig = false;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;
}
