{ config, lib, pkgs, primaryUserDefaults, ... }:

let
  inherit (lib) mkIf elem;
  inherit (primaryUserDefaults) username;
  homeManagerPresent = config ? home-manager;
  caskPresent = cask: lib.any (x: x.name == cask) config.homebrew.casks;
  brewEnabled = config.homebrew.enable;
  homePackages = config.home-manager.users.${username}.home.packages;

in {
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.fish.interactiveShellInit = mkIf brewEnabled ''
    if test -d (brew --prefix)"/share/fish/completions"
      set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
  '';

  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/services"
    "nrlquaker/createzap"
  ];

  # Prefer installing application from the Mac App Store
  homebrew.masApps = {
    "1Password for Safari" = 1569813296;
    Slack = 803453959;
    "Tailscale" = 1475387142;
    "Things 3" = 904280696;
    "Microsoft Remote Desktop" = 1295203466;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "1password"
    "1password-cli"
    "amethyst"
    "firefox"
    "google-drive"
    "google-chrome"
    "transmit"
    "devtoys"
    "moneymoney"
    "obsidian"
    "thunderbird"
    "whatsapp"
  ];

  # Configuration related to casks
  home-manager.users.ts =
    mkIf (caskPresent "1password-cli" && config ? home-manager) {

      programs.ssh.enable = true;
      programs.ssh.extraConfig = ''
        # Only set `IdentityAgent` not connected remotely via SSH.
        # This allows using agent forwarding when connecting remotely.
        Match host * exec "test -z $SSH_TTY"
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '';
      home.shellAliases = {
        # cachix = mkIf (elem pkgs.cachix homePackages) "op plugin run -- cachix";
        gh =
          mkIf (elem pkgs.gh homePackages) "op plugin run --account my -- gh";
        nixpkgs-review = mkIf (elem pkgs.nixpkgs-review homePackages)
          "op run -- nixpkgs-review";
      };
      home.sessionVariables = {
        #GITHUB_TOKEN = "op://Private/d4kwckaojdngif365gyhukyfre/CLI/token";
        #GITHUB_TOKEN = "op read op://Private/d4kwckaojdngif365gyhukyfre/CLI/token --account my";
        OP_SESSION_TIMEOUT = "1800";
      };
    };

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [ ];
}
