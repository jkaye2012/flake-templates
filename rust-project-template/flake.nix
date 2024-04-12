{
  description = "Replace me";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          f = fenix.packages.${system};
        in
          {
            devShells.default = 
              pkgs.mkShell {
                name = "replace-me";
                packages = [
                  f.stable.toolchain
                  pkgs.linuxPackages_latest.perf
                  pkgs.lldb
                ];
              };
          }
      );
}
