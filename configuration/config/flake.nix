{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
  };
  outputs = { self, nixpkgs, impermanence, ... } : {
  nixosConfigurations."Gorciu-Computer" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./configuration.nix
      impermanence.nixosModules.impermanence
    ];
  };
  };
}
