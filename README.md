# My personal nixpkgs

```shell
nix build .#darwinConfigurations.TobiasMacbookPro.system
```

## Manual Requirements

### Install Rosetta 2

```bash
softwareupdate --install-rosetta --agree-to-license
```

## Troubeshooting

### Hash issues

When there is a hash issue, check home/neovim.nix for adding a updated hash

## VS Code Insiders / Homebrew note (short)

On macOS the Homebrew activation has been adjusted so `bin/apply` no longer
runs the destructive `zap` cleanup that can remove application data
(e.g. VS Code - Insiders user accounts and trusted folders). The activation
now uses `cleanup`, which avoids calling cask zaps that delete user data.

As an extra safety measure `bin/apply` also performs an optional backup of
common VS Code Insiders data paths before the system switch and restores
them afterwards. This backup is enabled by default. To disable it run:

```bash
KEEP_VSCODE_INSIDERS_BACKUP=0 bin/apply
```

After a successful run VS Code Insiders should retain logins and trusted
folder settings.
