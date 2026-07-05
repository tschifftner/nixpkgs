{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    escapeTime = 0;
    historyLimit = 3000;
    extraConfig = ''
      set -g set-clipboard off
      set -g display-time 2000
      set -g status-interval 5
    '';
  };
}
