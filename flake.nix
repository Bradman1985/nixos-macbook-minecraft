{
  description = "NixOS configuration for 2009 MacBook Pro Minecraft server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-minecraft, flake-utils, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.macbook-server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-hardware.nixosModules.apple-macbook-pro-5-5
          nix-minecraft.nixosModules.minecraft-servers
          ./configuration.nix
          ./mcservers.nix
        ];
        specialArgs = { inherit nix-minecraft; };
      };
    };
}
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
