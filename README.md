# My personal nixpkgs

```shell
nix build .#darwinConfigurations.TobiasMacbookPro.system
```

## Manual Requirements

### Install Rosetta 2

```bash 
softwareupdate --install-rosetta --agree-to-license
```