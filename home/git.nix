{ pkgs, ... }:

{
  # Git
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
  # Aliases config in ./configs/git-aliases.nix
  programs.git.enable = true;

  programs.git.settings = {
    diff.colorMoved = "default";
    pull.rebase = true;
    init = { defaultBranch = "main"; };
    push.autoSetupRemote = true;
    user.email = "tobias" + "@" + "schifftner.de";
    user.name = "Tobias Schifftner";
  };

  programs.git.ignores = [ ".DS_Store" ".tmp" ];

  # Enhanced diffs
  programs.diff-so-fancy.enable = true;
  programs.diff-so-fancy.settings.changeHunkIndicators = true;
  programs.diff-so-fancy.settings.markEmptyLines = true;
  programs.diff-so-fancy.enableGitIntegration = true;

  # GitHub CLI
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  # Aliases config in ./gh-aliases.nix
  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
}
