{ pkgs, ... }:

{
  # Git
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
  # Aliases config in ./configs/git-aliases.nix
  programs.git.enable = true;

  programs.git.extraConfig = {
    diff.colorMoved = "default";
    pull.rebase = true;
    init = { defaultBranch = "main"; };
    push.autoSetupRemote = true;
  };

  programs.git.ignores = [ ".DS_Store" ".tmp" ];

  programs.git.userEmail = "tobias" + "@" + "schifftner.de";
  programs.git.userName = "Tobias Schifftner";

  # Enhanced diffs
  programs.git.diff-so-fancy.enable = true;
  programs.git.diff-so-fancy.changeHunkIndicators = true;
  programs.git.diff-so-fancy.markEmptyLines = true;

  # GitHub CLI
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  # Aliases config in ./gh-aliases.nix
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
}
