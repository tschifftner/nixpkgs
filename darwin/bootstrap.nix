{ config, lib, pkgs, ... }:

{
  nix.settings = {
    substituters =
      [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    trusted-users = [ "@admin" ];

    # https://github.com/NixOS/nix/issues/7273
    auto-optimise-store = false;

    experimental-features = [ "nix-command" "flakes" ];

    extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") [
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Recommended when using `direnv` etc.
    keep-derivations = true;
    keep-outputs = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nixfmt
    dnsutils # `dig` + `nslookup`
    raycast
    iterm2
    trippy # A network diagnostic tool
  ];

  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  # This is a workaround
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [
    "/Applications"
    "/Applications/Nix Apps"
    "/share/bash-completion"
    "/share/zsh"
    "/share/fish"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = pkgs.rev or pkgs.dirtyRev or null;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;
  # Needed to address bug where $PATH is not properly set for fish:
  # https://github.com/LnL7/nix-darwin/issues/122
  programs.fish.shellInit = ''
    for p in (string split : ${config.environment.systemPath})
      if not contains $p $fish_user_paths
        set -g fish_user_paths $fish_user_paths $p
      end
    end
  '';

  # Make Fish the default shell
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
