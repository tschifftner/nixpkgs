{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.extensions = 
      (with pkgs.vscode-extensions; [
        github.github-vscode-theme
        bbenoist.nix
        brettm12345.nixfmt-vscode
        ibm.output-colorizer
        dotjoshjohnson.xml
        redhat.vscode-yaml
        mkhl.direnv
        formulahendry.code-runner
        usernamehw.errorlens
        github.copilot
        github.copilot-chat

        # vscode theme
        pkief.material-icon-theme
        github.github-vscode-theme

        # general
        editorconfig.editorconfig
        yzhang.markdown-all-in-one
        ibm.output-colorizer
        christian-kohler.path-intellisense

        # Prettier
        esbenp.prettier-vscode

        # html
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        vincaslt.highlight-matching-tag

        # Javascipt / Typescript
        mikestead.dotenv
        dbaeumer.vscode-eslint
        prisma.prisma

        # Tailwind
        bradlc.vscode-tailwindcss

        # bash
        mads-hartmann.bash-ide-vscode
        foxundermoon.shell-format
        timonwong.shellcheck

        # Rest
        humao.rest-client

        # Python dev
        # ms-python.python
        # ms-python.vscode-pylance
        # charliermarsh.ruff

        # ms-toolsai.jupyter
        # ms-toolsai.vscode-jupyter-slideshow
        # ms-toolsai.jupyter-renderers
        # ms-toolsai.jupyter-keymap
        # ms-toolsai.vscode-jupyter-cell-tags

        # RPA
        #robocorp.robocorp-code
        #robocorp.robotframework-lsp

        # Marketplace-Block-Migration
        visualstudioexptteam.vscodeintellicode
        biomejs.biome
        tamasfe.even-better-toml
        bierner.markdown-mermaid
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # quickly convert text to and from various formats (Encode/Decode)
          name = "ecdc";
          publisher = "mitchdenny";
          version = "1.8.0";
          sha256 = "sha256-W2WlngFC5pAAjkj4lQNR5yPJZiedkjqGZHldjx8m7IU=";
        }
        {
          name = "vscode-typescript-next";
          publisher = "ms-vscode";
          version = "5.9.20250702";
          sha256 = "sha256-SASBHJtk4c6MedieH75K1Xl1F5c212x9og0R9IigVd4=";
        }
        {
          name = "playwright";
          publisher = "ms-playwright";
          version = "1.1.15"; # Stand: 4.6.2025
          sha256 = "sha256-1fdUyzJitFfl/cVMOjEiuBS/+FTGttilXoZ8txZMmVs=";
        }
        # {
        #   name = "geminicodeassist";
        #   publisher = "Google";
        #   version = "0.5.1";
        #   sha256 = ""; # Bitte nach erstem Build mit dem richtigen Hash ersetzen
        # }
      ];

    profiles.default.userSettings = {
      geminicodeassist.updateChannel = "Insiders";
      update.mode = "none";
      window.zoomLevel = 0;

      terminal.integrated.shell.linux = "${pkgs.zsh}/bin/zsh";

      # Moved to its own file mcp.json (not yet supported by home-manager)
      # mcp = {
      #   servers = {
      #     github = {
      #       url = "https://api.githubcopilot.com/mcp/";
      #     };

      #     playwright = {
      #       command = "npx";
      #       args = [
      #         "@playwright/mcp@latest"
      #       ];
      #     };

      #     browsermcp = {
      #       command = "npx";
      #       args = [
      #         "@browsermcp/mcp@latest"
      #       ];  
      #     };

      #     context7 = {
      #       command = "npx";
      #       args = [ "-y" "@upstash/context7-mcp" ];
      #     };

      #   };
      # };


      editor = {
        fontFamily =
          "'JetbrainsMono', 'Hack Nerd Font Mono', 'Hasklug Nerd Font', 'monospace', 'Droid Sans Fallback'";
        fontLigatures = true;
        inlineSuggest.enabled = true;
        bracketPairColorization.enabled = true;
        formatOnSave = true;
        defaultFormatter = "biomejs.biome";
        codeActionsOnSave = { quickfix.biome = "explicit"; };
      };

      workbench = {
        iconTheme = "material-icon-theme";
        colorTheme = "GitHub Dark Dimmed"; # Material Theme Ocean High Contrast
        preferredDarkColorTheme = "GitHub Dark Dimmed";
        editor.showIcons = true;
        panel.showLabels = false;
      };

      # Formatting
      "[css]" = { editor.defaultFormatter = "prettier"; };
      "[yaml]" = { editor.defaultFormatter = "esbenp.prettier-vscode"; };
      "[markdown]" = { editor.defaultFormatter = "esbenp.prettier-vscode"; };
      "[toml]" = { editor.defaultFormatter = "tamasfe.even-better-toml"; };
      "[dotenv]" = { editor.defaultFormatter = "foxundermoon.shell-format"; };

      scm = { defaultViewMode = "tree"; };

      # Python
      notebook.formatOnSave.enabled = true;
      python.formatting.provider = "black";

      jupyter = {
        # required by qgrid
        widgetScriptSources = [ "jsdelivr.com" "unpkg.com" ];
        alwaysTrustNotebooks = true;
      };

      window.menuBarVisibility = "toggle";
      
      # GitHub Copilot Chat
      chat.tools.autoApprove = true;
      github.copilot.chat.languageContext.inline.typescript.enabled = true;
      github.copilot.chat.edits.temporalContext.enabled = true;
      github.copilot.chat.codesearch.enabled = true;
      github.copilot.chat.languageContext.fix.typescript.enabled = true;
      github.copilot.chat.localeOverride = "de";
      chat.agent.maxRequests = 500;
      
      files.exclude = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/Thumbs.db" = true;
        "**/*.olean" = true;
      };

    };
  };
}
