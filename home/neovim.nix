{ config, pkgs, lib, ... }:

let
  githubNvimTheme = pkgs.vimUtils.buildVimPlugin {
    name = "github-nvim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "v1.0.1";
      sha256 =
	      "sha256-30+5q6qE1GCetNKdUC15LcJeat5e0wj9XtNwGdpRsgk="; # Provide the correct sha256 hash here
    };
  };
in {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      go-nvim
      copilot-vim
      githubNvimTheme # Add this line
    ];
    extraConfig = ''
      set number relativenumber
      colorscheme github_dark_dimmed
    '';
  };
}
