{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "GitHub_Dark_Dimmed";
    font.name = "JetBrainsMono";
    environment = { "LS_COLORS" = "1"; };
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    settings = {
      allow_remote_control = "yes";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      term = "xterm-256color";
      tab_bar_style = "powerline";
      tab_font_size = "14.0";
      active_tab_background = "#d18616";
      active_tab_foreground = "#202020";
      inactive_tab_background = "#2d333b";
      inactive_tab_foreground = "#adbac7";
      tab_bar_margin_color = "#22272e";
      tab_bar_background = "#2d333b";
      tab_bar_edge = "top";
      tab_bar_margin_height = "1.0 3.0";
      tab_title_max_length = "35";
      tab_separator = " ┇";
      tab_title_template =
        "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}:{title}";

      window_margin_width = "3.0";
      enabled_layouts = "all";
      copy_on_select = "true";
    };

    keybindings = {
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";
      "cmd+0" = "goto_tab 10";
    };

    extraConfig = "";
  };
}
