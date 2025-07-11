{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, mac-app-util, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      specialArgs = { inherit inputs primaryUserDefaults; };

      primaryUserDefaults = {
        username = "ts";
        fullName = "Tobias Schifftner";
        email = "tobias@schifftner.de";
        nixConfigDirectory = "/Users/ts/.config/nixpkgs";
      };

      modules = with primaryUserDefaults; [
        ./darwin
        mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          users.users.${username}.home = "/Users/${username}";
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
        }
      ];

    in {

      darwinConfigurations.TobiasMacbookPro =
        darwin.lib.darwinSystem { inherit system pkgs modules specialArgs; };

      darwinConfigurations.githubCI =
        darwin.lib.darwinSystem { inherit system pkgs modules specialArgs; };

      homeConfigurations.ts = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home
          { home.username = "ts"; home.homeDirectory = "/Users/ts"; }
        ];
        extraSpecialArgs = specialArgs;
      };

      # Linux CI-Konfiguration für GitHub Actions
      homeConfigurations.runner = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
        modules = [
          { home.username = "runner"; home.homeDirectory = "/home/runner"; home.stateVersion = "24.05"; }
        ];
        extraSpecialArgs = specialArgs;
      };
    };
}
