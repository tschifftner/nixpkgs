# Personal nixpkgs Configuration

The owner of the GitHub repo is **tschifftner**.

Make sure all terminal commands work on a **Macbook** with **zsh** shell.

This repository contains a comprehensive **nix-darwin** and **home-manager** configuration for macOS development environments.

---

## 📁 Project Structure

The repository follows a **flat and predictable** structure for Nix configurations:

```
.
├── .github/
│   ├── copilot-instructions.md    # This file
│   ├── prompts/                   # AI prompt templates
│   └── workflows/                 # CI/CD workflows
├── bin/                          # Helper scripts
│   ├── apply                     # Apply configuration changes
│   ├── check                     # Check configuration validity
│   ├── cleanup                   # Clean up old generations
│   └── update                    # Update flake inputs
├── darwin/                       # nix-darwin system configuration
│   ├── bootstrap.nix             # Basic Nix setup
│   ├── general.nix               # System-wide settings
│   ├── homebrew.nix              # Homebrew packages and casks
│   └── default.nix               # Main Darwin configuration
├── home/                         # home-manager user configuration
│   ├── packages.nix              # User packages and programs
│   ├── vscode.nix                # VS Code configuration
│   ├── fish.nix                  # Fish shell configuration
│   ├── git.nix                   # Git configuration
│   ├── kitty.nix                 # Kitty terminal configuration
│   └── default.nix               # Main home-manager configuration
├── lib/                          # Custom Nix library functions
├── modules/                      # Custom Nix modules
├── flake.nix                     # Main flake configuration
└── flake.lock                    # Locked flake inputs
```

📌 **Rules:**

- **Flat is better than nested** - avoid deep directory hierarchies
- **Separate concerns** - darwin/ for system, home/ for user configuration
- **No generic 'helpers' folder** - use descriptive names like bin/, lib/, modules/

---

## 🔧 Nix Best Practices

### ✅ Flake Management

```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs-unstable

# Check flake validity
nix flake check

# Show flake info
nix flake show
```

### ✅ System Management

```bash
# Build system configuration
nix build .#darwinConfigurations.TobiasMacbookPro.system

# Apply system changes
sudo darwin-rebuild switch --flake .

# Apply home-manager changes only
home-manager switch --flake .

# Check what would change
sudo darwin-rebuild build --flake .
```

### ✅ Nix Code Style

```nix
# ✅ GOOD: Use consistent formatting
{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    
    extensions = with pkgs.vscode-extensions; [
      # Group related extensions
      github.copilot
      github.copilot-chat
      
      # JavaScript/TypeScript
      ms-vscode.vscode-typescript-next
      dbaeumer.vscode-eslint
    ];
  };
}

# ❌ BAD: Inconsistent spacing and grouping
{config,lib,pkgs,...}:{programs.vscode={enable=true;extensions=[pkgs.vscode-extensions.github.copilot];};}
```

### ✅ Configuration Principles

- **Declarative over imperative** - define what you want, not how to get there
- **Reproducible** - same configuration should produce same result anywhere
- **Modular** - break configuration into logical modules
- **Version controlled** - all configuration should be in git
- **Tested** - use `nix flake check` and CI to validate changes

---

## 🆚 VS Code Configuration

### ✅ Recommended Extensions

Essential extensions are automatically installed via Nix configuration:

```nix
# Core development extensions
github.copilot                    # AI-powered code completion
github.copilot-chat               # AI chat assistant
biomejs.biome                     # Fast formatter and linter
ms-vscode.vscode-typescript-next  # Enhanced TypeScript support

# Language support
bbenoist.nix                      # Nix language support
brettm12345.nixfmt-vscode         # Nix formatter
redhat.vscode-yaml                # YAML support
dotjoshjohnson.xml                # XML support

# Development tools
usernamehw.errorlens              # Inline error display
formulahendry.code-runner         # Run code snippets
christian-kohler.path-intellisense # Path autocompletion
mkhl.direnv                       # direnv integration

# Git and version control
# (Built into VS Code)

# Theme and UI
pkief.material-icon-theme         # Material icons
github.github-vscode-theme        # GitHub theme
```

### ✅ Formatter and Linter Settings

The VS Code configuration includes these formatting settings:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "biomejs.biome",
  "editor.codeActionsOnSave": {
    "quickfix.biome": "explicit"
  },

  // Language-specific formatters
  "[nix]": {
    "editor.defaultFormatter": "brettm12345.nixfmt-vscode"
  },
  "[yaml]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[toml]": {
    "editor.defaultFormatter": "tamasfe.even-better-toml"
  }
}
```

### ✅ GitHub Copilot Settings

```json
{
  "chat.tools.autoApprove": true,
  "github.copilot.enable": {
    "*": true,
    "nix": true,
    "markdown": true
  }
}
```

---

## 🔨 Development Workflow

### ✅ Making Changes

1. **Edit configuration files** in appropriate modules
2. **Check syntax** with `nix flake check`
3. **Build configuration** with `nix build .#darwinConfigurations.TobiasMacbookPro.system`
4. **Apply changes** with `sudo darwin-rebuild switch --flake .`
5. **Commit changes** with conventional commit messages
6. **Push to GitHub** and create a pull request if needed
7. **Review changes** in CI and ensure everything passes
8. **Merge changes** once approved
9. **Test the configuration** on your machine to ensure everything works as expected

### ✅ Adding New Packages

When ask to install a new package, do not run `brew install` or `nix-env -i`. Instead, add the package to the appropriate Nix configuration files.

```nix
# Add to home/packages.nix for user packages
home.packages = with pkgs; [
  # Development tools
  nodejs
  typescript
  # ... existing packages
  new-package  # Add here
];

# Add to darwin/homebrew.nix for GUI applications
homebrew.casks = [
  "existing-app"
  "new-gui-app"  # Add here
];
```

### ✅ Adding VS Code Extensions

```nix
# Add to home/vscode.nix
profiles.default.extensions = with pkgs.vscode-extensions; [
  # ... existing extensions
  publisher.extension-name
] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "extension-name";
    publisher = "publisher-name";
    version = "1.0.0";
    sha256 = "sha256-HASH";
  }
];
```

---

### ✅ Git Commits

- Use **conventional commit messages** (e.g., `feat: add user authentication`, `fix: correct typo in README`)
- Keep commit messages **short and descriptive**
- Use these prefixes:
  - `feat:` - new features
  - `fix:` - bug fixes
  - `docs:` - documentation changes
  - `style:` - formatting changes
  - `refactor:` - code refactoring
  - `test:` - test additions
  - `chore:` - maintenance tasks
- Ensure nixfmt is run on all Nix files before committing

---

## 🔥 Final Thoughts

1. **Avoid over-engineering** - Keep configurations simple and readable
2. **Prioritize readability over cleverness** - Future you will thank you
3. **Only abstract when it provides real value** - Don't create modules unnecessarily
4. **Leverage Nix's reproducibility** - Everything should be declarative
5. **Use the ecosystem** - Prefer nixpkgs packages over manual installations
6. **Document decisions** - Add comments explaining complex configurations
7. **Test changes** - Use `nix flake check` and build before applying, test also on Terminal
8. **Version everything** - All configuration should be in version control

---
