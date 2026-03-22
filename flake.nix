{
  description = "AF's Nix User Repository";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system} = import ./pkgs { inherit pkgs; };
      
      overlays.default = final: prev: {
        classin = final.callPackage ./pkgs/classin { };
      };
    };
}