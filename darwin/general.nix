{ pkgs, ... }:

{
  # Networking
  networking.dns = [ "1.1.1.1" "8.8.8.8" ];

  networking.knownNetworkServices =
    [ "WLAN" "Ethernet Adaptor" "Thunderbolt Bridge" ];

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ terminal-notifier ];
  programs.nix-index.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override {
      fonts = [ "Hasklig" "Hack" "JetBrainsMono" "Meslo" ];
    })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to use TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
