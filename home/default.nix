{
  # Do not change!
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./aliases.nix
    ./bash.nix
    ./config-files.nix
    ./fish.nix
    ./git-aliases.nix
    ./gh-aliases.nix
    ./git.nix
    ./kitty.nix
    ./neovim.nix
    ./packages.nix
    ./ssh.nix
    ./starship.nix
    ./thunderbird.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
