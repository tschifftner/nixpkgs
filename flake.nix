{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
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
        home-manager.darwinModules.home-manager
        {
          users.users.${username}.home = "/Users/${username}";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          home-manager.extraSpecialArgs = specialArgs;
        }
      ];

    in {

      darwinConfigurations.TobiasMacbookPro =
        darwin.lib.darwinSystem { inherit system pkgs modules specialArgs; };
    };
}
