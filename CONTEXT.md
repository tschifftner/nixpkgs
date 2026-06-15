# Context: tschifftner/nixpkgs

## Purpose

Personal nix-darwin + home-manager repository for macOS (aarch64-darwin) system and user configuration.

## Glossary

| Term | Definition |
|------|------------|
| **System config** | nix-darwin configuration in `darwin/` (system-level: networking, fonts, PAM, defaults) |
| **User config** | home-manager configuration in `home/` (user-level: packages, shells, editors, aliases) |
| **Homebrew** | Package manager for macOS GUI apps (casks) and some CLI tools not in nixpkgs |
| **Orbstack** | Lightweight container runtime replacing Docker Desktop / colima |
| **cmux** | Terminal multiplexer, replacing Ghostty |
| **Zsh** | Primary interactive shell; bash is only preserved as system binary |
| **Taskfile** | Go-based task runner (`go-task`) for common operations (validate, apply, home, update) |

## Key Decisions

- **Pi (agent CLI):** Managed via `pnpm i -g pi`, not via nixpkgs, to get frequent updates.
- **Firebase-tools:** Managed via `npm i -g firebase-tools`, not via nixpkgs, to get frequent updates.
- **Kubernetes tools:** Removed from config (not actively used); documented in ADR-0001 for easy restoration.
- **Shells:** Only Zsh is configured by home-manager. Bash and Fish configs removed (bash binary remains).
- **Docker:** Docker and docker-compose packages remain for Orbstack compatibility.
