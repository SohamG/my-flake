{
  description = "Flake for ocs-url with ocs:// support";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs"; };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      packs = packages.x86_64-linux;
    in {
      packs.ocs-url =
        import ./packages/ocs-url.nix { inherit pkgs; };

      packs.realmd = import ./packages/realmd.nix { inherit pkgs; };

    };
}

