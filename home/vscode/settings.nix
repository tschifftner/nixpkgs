{ ... }:

{
  # VS Code User Settings
  programs.vscode.profiles.default.userSettings = {
    # Update and general settings
    update.mode = "none";
    window.zoomLevel = 0;
    window.menuBarVisibility = "toggle";

    # Terminal settings
    terminal.integrated.shell.linux = "/bin/zsh";

    # Editor settings
    editor = {
      fontFamily = "'JetbrainsMono', 'Hack Nerd Font Mono', 'Hasklug Nerd Font', 'monospace', 'Droid Sans Fallback'";
      fontLigatures = true;
      inlineSuggest.enabled = true;
      bracketPairColorization.enabled = true;
      formatOnSave = true;
      codeActionsOnSave = {
        source.organizeImports = "explicit";
      };
    };

    # Workbench appearance
    workbench = {
      iconTheme = "material-icon-theme";
      colorTheme = "GitHub Dark Dimmed";
      preferredDarkColorTheme = "GitHub Dark Dimmed";
      editor.showIcons = true;
      panel.showLabels = false;
    };

    # Language-specific formatting
    "[css]" = { editor.defaultFormatter = "prettier"; };
    "[yaml]" = { editor.defaultFormatter = "esbenp.prettier-vscode"; };
    "[markdown]" = { editor.defaultFormatter = "esbenp.prettier-vscode"; };
    "[toml]" = { editor.defaultFormatter = "tamasfe.even-better-toml"; };
    "[dotenv]" = { editor.defaultFormatter = "foxundermoon.shell-format"; };

    # Source control
    scm = { defaultViewMode = "tree"; };

    # Python (commented out - uncomment if needed)
    # notebook.formatOnSave.enabled = true;
    # python.formatting.provider = "black";

    # Jupyter (commented out - uncomment if needed)
    # jupyter = {
    #   widgetScriptSources = [ "jsdelivr.com" "unpkg.com" ];
    #   alwaysTrustNotebooks = true;
    # };

    # GitHub Copilot Chat settings
    chat.tools.autoApprove = true;
    github.copilot.chat.languageContext.inline.typescript.enabled = true;
    github.copilot.chat.edits.temporalContext.enabled = true;
    github.copilot.chat.codesearch.enabled = true;
    github.copilot.chat.languageContext.fix.typescript.enabled = true;
    github.copilot.chat.localeOverride = "de";
    chat.agent.maxRequests = 500;

    # File exclusions
    files.exclude = {
      "**/.git" = true;
      "**/.svn" = true;
      "**/.hg" = true;
      "**/CVS" = true;
      "**/.DS_Store" = true;
      "**/Thumbs.db" = true;
      "**/*.olean" = true;
    };

    # Tools
    biome.enabled = false;
    geminicodeassist.updateChannel = "Insiders";
  };
}
