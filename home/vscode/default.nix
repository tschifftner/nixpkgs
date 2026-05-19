{ ... }:

{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  # VS Code Insiders is installed via Homebrew Cask (visual-studio-code@insiders)
  # We disable VS Code installation through Nix and only manage extensions/settings
  programs.vscode = {
    enable = false;  # Disable Nix installation, use Homebrew version
  };
}
