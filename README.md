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
