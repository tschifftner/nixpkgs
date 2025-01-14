{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions;
      [
        github.github-vscode-theme
        bbenoist.nix
        brettm12345.nixfmt-vscode
        ibm.output-colorizer
        dotjoshjohnson.xml
        redhat.vscode-yaml
        mkhl.direnv
        formulahendry.code-runner
        usernamehw.errorlens

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
        ms-python.python
        ms-python.vscode-pylance
        charliermarsh.ruff

        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-slideshow
        ms-toolsai.jupyter-renderers
        ms-toolsai.jupyter-keymap
        ms-toolsai.vscode-jupyter-cell-tags

        # RPA
        #robocorp.robocorp-code
        #robocorp.robotframework-lsp

      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.86.0";
          sha256 = "sha256-JsbaoIekUo2nKCu+fNbGlh5d1Tt/QJGUuXUGP04TsDI=";
        }
        {
          name = "vscodeintellicode";
          publisher = "visualstudioexptteam";
          version = "1.2.30";
          sha256 = "0lg298047vmy31fnkczgpw78k3yxzpiip0ln1wixy70hdpwsfqbz";
        }
        {
          name = "1Password";
          publisher = "op-vscode";
          version = "v1.0.4";
          sha256 =
            "b3a69cb9ef248052dfe5fb3803b97e2187e189b758efa70b708c0797ee785959";
        }
        {
          name = "shebang-snippets";
          publisher = "rpinski";
          version = "1.0.1";
          sha256 = "sha256-Buwp7XwfWogQt0WXswxVMa9c7gkVBDPvyy+9WeIn43A=";
        }
        {
          name = "commit-message-editor";
          publisher = "adam-bender";
          version = "0.25.0";
          sha256 = "sha256-Vw5RkY3W4FqKvCWlscxxpGQsfm3g2bZJ5suityQ3mG8=";
        }
        {
          # quickly convert text to and from various formats (Encode/Decode)
          name = "ecdc";
          publisher = "mitchdenny";
          version = "1.8.0";
          sha256 = "sha256-W2WlngFC5pAAjkj4lQNR5yPJZiedkjqGZHldjx8m7IU=";
        }
        {
          name = "biome";
          publisher = "biomejs";
          version = "2.2.2";
          sha256 = "sha256-bvO1JC7chd1JtlcggvDCK8ZBhvmkyK5cD6rh4zfIZZs=";
        }
        {
          name = "even-better-toml";
          publisher = "tamasfe";
          version = "0.19.2";
          sha256 = "sha256-JKj6noi2dTe02PxX/kS117ZhW8u7Bhj4QowZQiJKP2E=";
        }
        {
          name = "mdmath";
          publisher = "goessner";
          version = "2.7.4";
          sha256 = "sha256-DCh6SG7nckDxWLQvHZzkg3fH0V0KFzmryzSB7XTCj6s=";
        }

      ];

    userSettings = {
      update.mode = "none";
      window.zoomLevel = 0;

      terminal.integrated.shell.linux = "${pkgs.zsh}/bin/zsh";

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
