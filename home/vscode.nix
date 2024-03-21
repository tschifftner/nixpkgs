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

        # Tailwind
        bradlc.vscode-tailwindcss

        # bash
        mads-hartmann.bash-ide-vscode
        foxundermoon.shell-format
        timonwong.shellcheck

        # Rest
        humao.rest-client

        # Python dev
        ms-python.black-formatter
        ms-python.python
        ms-python.vscode-pylance

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
          version = "0.1.4";
          sha256 = "sha256-UQpt4Wr8PPY5PVGWSEs8rGnohm7xe4vdNeKocJByNho=";
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
      };

      workbench = {
        iconTheme = "material-icon-theme";
        colorTheme = "GitHub Dark Dimmed"; # Material Theme Ocean High Contrast
        preferredDarkColorTheme = "GitHub Dark Dimmed";
        editor.showIcons = true;
      };

      scm = { defaultViewMode = "tree"; };

      notebook.formatOnSave.enabled = true;

      jupyter.widgetScriptSources =
        [ "jsdelivr.com" "unpkg.com" ]; # required by qgrid
      jupyter.alwaysTrustNotebooks = true;
      python.formatting.provider = "black";
      "[css]" = { editor.defaultFormatter = "prettier"; };
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
