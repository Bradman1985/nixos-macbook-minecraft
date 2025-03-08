{
  description = "NixOS config for 2009 MacBook Pro server";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, nix-minecraft, flake-utils, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.macbook-server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix nix-minecraft.nixosModules.minecraft ];
      };
    };
}