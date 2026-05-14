{ pkgs, ... }:

{
  # VS Code Extensions - organized by category
  programs.vscode.profiles.default.extensions = (with pkgs.vscode-extensions; [
    # GitHub & Git
    github.github-vscode-theme
    github.copilot
    github.copilot-chat

    # Nix
    bbenoist.nix
    brettm12345.nixfmt-vscode

    # Development Tools
    formulahendry.code-runner
    usernamehw.errorlens
    mkhl.direnv
    editorconfig.editorconfig
    christian-kohler.path-intellisense

    # File Format Support
    dotjoshjohnson.xml
    redhat.vscode-yaml
    ibm.output-colorizer
    yzhang.markdown-all-in-one
    bierner.markdown-mermaid
    tamasfe.even-better-toml

    # Themes & UI
    pkief.material-icon-theme

    # Formatting & Linting
    esbenp.prettier-vscode
    biomejs.biome

    # HTML & Web Development
    formulahendry.auto-close-tag
    formulahendry.auto-rename-tag
    vincaslt.highlight-matching-tag
    bradlc.vscode-tailwindcss

    # JavaScript/TypeScript
    mikestead.dotenv
    dbaeumer.vscode-eslint
    prisma.prisma

    # Shell & Bash
    mads-hartmann.bash-ide-vscode
    foxundermoon.shell-format
    timonwong.shellcheck

    # REST & API
    humao.rest-client

    # General Development
    visualstudioexptteam.vscodeintellicode

  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      # Encode/Decode utility
      name = "ecdc";
      publisher = "mitchdenny";
      version = "1.103.1";
      sha256 = "sha256-W2WlngFC5pAAjkj4lQNR5yPJZiedkjqGZHldjx8m7IU=";
    }
    {
      # Latest TypeScript support
      name = "vscode-typescript-next";
      publisher = "ms-vscode";
      version = "1.103.1";
      sha256 = "sha256-SASBHJtk4c6MedieH75K1Xl1F5c212x9og0R9IigVd4=";
    }
    {
      # Playwright testing
      name = "playwright";
      publisher = "ms-playwright";
      version = "1.103.1";
      sha256 = "sha256-1fdUyzJitFfl/cVMOjEiuBS/+FTGttilXoZ8txZMmVs=";
    }
  ];
}
