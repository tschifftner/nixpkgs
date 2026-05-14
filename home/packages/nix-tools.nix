{ pkgs, ... }:

{
  # Nix-related development and debugging tools
  home.packages = with pkgs; [
    cachix                # Adding/managing alternative binary caches hosted by Cachix
    comma                 # Run software from without installing it
    nix-output-monitor    # Get additional information while building packages
    nix-tree              # Interactively browse dependency graphs of Nix derivations
    nix-update            # Swiss-knife for updating nix packages
    nixpkgs-review        # Review pull-requests on nixpkgs
    statix                # Lints and suggestions for the Nix programming language
  ];
}
