# Agent Instructions: Personal nixpkgs & macOS Configuration

You are an expert AI agent managing a **nix-darwin** and **home-manager** repository for user **tschifftner**.
Target System: **macOS (Macbook)** | Shell: **zsh**

## 📁 Repository Structure & Rules
- **Flat over nested:** Maintain a flat directory hierarchy.
- **Separation:** `darwin/` for system config, `home/` for user config. No generic 'helpers' folders.


```tree
.
├── bin/apply                  # Script to apply ALL configuration changes
├── bin/check                  # Script to check configuration validity
├── darwin/                    # nix-darwin system config (bootstrap.nix, general.nix, homebrew.nix, default.nix)
├── home/                      # home-manager user config (packages.nix, vscode.nix, default.nix, etc.)
├── flake.nix                  # Main flake configuration
└── flake.lock                 # Locked flake inputs

```

## ⚡ Fast Feedback Loop (Strict Rule)
- BEFORE running `bin/apply`, you MUST run `bin/check` or `nix flake check` to validate syntax and types.
- If `bin/check` fails, DO NOT run apply. Fix the code immediately based on the evaluation error.
- If you ONLY modified files inside `home/` (e.g., vscode.nix, packages.nix), you can run `home-manager switch --flake .` directly instead of the heavy `bin/apply` to save time.

## 🚀 Speed Optimizations
1. **Never apply blindly:** Run `nix flake check` first. It takes 2 seconds. Fix errors there.
2. **Scoping:** If only editing `home/` files, use `home-manager switch --flake .` instead of the full system apply.

## 🔧 Nix Workflow & Execution Rules

### 1. Apply Changes (Crucial)
- NEVER run `brew install`, `nix-env`, `darwin-rebuild`, or `home-manager switch` directly.
- **To apply ANY changes, you MUST run:** `bin/apply`
- **To validate syntax before applying, run:** `bin/check` or `nix flake check`

### 2. Modifying Configurations
- **User Packages:** Append to `home.packages` in `home/packages.nix`.
- **macOS GUI Apps (Casks/Brewhome):** Append to `homebrew.casks` or `homebrew.brews` in `darwin/homebrew.home.nix`.
- **VS Code Extensions:** Append to `programs.vscode.extensions` in `home/vscode.nix`. Use `pkgs.vscode-extensions` or `pkgs.vscode-utils.extensionsFromVscodeMarketplace`.

## 💎 Nix Code Style & Principles
- **Formatting:** Always format Nix files using `nixfmt`.
- **Declarative Only:** Everything must be defined declaratively in the Nix configuration. No imperative side-effects.
- **Grouping:** Group related packages or extensions logically with comments.

## 📝 Commits
- Use short Conventional Commits (`feat:`, `fix:`, `chore:`, `style:`).

## Agent skills

### Issue tracker

Issues and PRDs live as GitHub issues. See `docs/agents/issue-tracker.md`.

### Triage labels

Default canonical labels (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `CONTEXT.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.
