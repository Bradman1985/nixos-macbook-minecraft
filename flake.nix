{
  description = "NixOS configuration for 2009 MacBook Pro Minecraft server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nix-minecraft, flake-utils, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.macbook-server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nix-minecraft.nixosModules.minecraft-servers
          ./configuration.nix
          ./mcservers.nix
        ];
        specialArgs = { inherit nix-minecraft; };
      };
    };
}
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
