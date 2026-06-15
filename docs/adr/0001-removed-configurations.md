# ADR 0001: Removed configurations (cleanup 2025-06)

## Status

Accepted (2025-06-15)

## Context

The repository had accumulated packages, casks, and configuration that were no longer actively used.
Running `bin/apply` would break frequently due to outdated overlays and unused packages drifting
from nixpkgs-unstable. The goal was to slim down the configuration to only actively-used tools
and document removed items so they can be restored easily.

## Decision

The following configurations were removed. Each section explains why and how to re-enable.

### Overlays

| Removed | Reason | How to restore |
|---------|--------|----------------|
| `overlays/helm-darwin-paths.nix` | `kubernetes-helm` not used; overlay passed `doCheck` arg that newer nixpkgs doesn't accept | Re-create an overlay pinning a specific helm version or patching the check phase |

### Packages

| Removed | Reason | How to restore |
|---------|--------|----------------|
| `kubernetes-helm` | Not actively using Kubernetes | Add to `home/packages/kubernetes.nix` |
| `kubectl` | Not actively using Kubernetes | Add to `home/packages/kubernetes.nix` |
| `kubectx` | Not actively using Kubernetes | Add to `home/packages/kubernetes.nix` |
| `kustomize` | Not actively using Kubernetes | Add to `home/packages/kubernetes.nix` |
| `colima` | Replaced by Orbstack | Add to `home/packages/development.nix` |
| `pi-coding-agent` | Managed via `pnpm i -g pi` for faster updates | Add to `home/packages/development.nix` |
| `firebase-tools` | Managed via `npm i -g firebase-tools` | Add to `home/packages/development.nix` |
| `claude-code` | Not actively used | Add to `home/packages/ai-tools.nix` |

### Shells

| Removed | Reason |
|---------|--------|
| `programs.fish` (full config incl. plugins, theme switching) | Primary shell is Zsh |
| `programs.bash` (home-manager config: history, completion) | Bash binary remains; no HM config needed |

### Homebrew casks

| Removed | Reason | How to restore |
|---------|--------|----------------|
| `amethyst` | No longer using tiling WM | Add to `homebrew.casks` in `darwin/homebrew.nix` |
| `calibre*` | Kept per user request | — |
| `canva` | Not actively used | Add to `homebrew.casks` |
| `chatbox` | Not actively used | Add to `homebrew.casks` |
| `claude` | Not actively used | Add to `homebrew.casks` |
| `devtoys` | Not actively used | Add to `homebrew.casks` |
| `ghostty` | Replaced by cmux | Add to `homebrew.casks` |
| `jdownloader` | Not actively used | Add to `homebrew.casks` |
| `steam` | Not actively used | Add to `homebrew.casks` |
| `thorium` | Not actively used | Add to `homebrew.casks` |
| `warp` | Not actively used | Add to `homebrew.casks` |

### Homebrew MAS apps

| Removed | Reason | How to restore |
|---------|--------|----------------|
| `Slack` | Not actively used | Add to `homebrew.masApps` |
| `Microsoft Remote Desktop` | Not actively used | Add to `homebrew.masApps` |

### Homebrew formulae (manually removed via brew)

| Removed | Reason |
|---------|--------|
| `duckdb` | Not actively used |
| `gnupg` | Not actively used |

## Consequences

- `bin/apply` should no longer break due to the helm overlay.
- Configuration is easier to maintain with fewer moving parts.
- Removed items can be restored by looking up the "How to restore" column above.
- Active tools get faster updates (pi, firebase-tools via npm instead of nixpkgs).
