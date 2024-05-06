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
          f = with fenix.packages.${system}; combine [
            stable.toolchain
            targets.wasm32-unknown-unknown.stable.rust-std
          ];
        in
          {
            devShells.default = 
              pkgs.mkShell {
                name = "replace-me";

                packages = [
                  f
                  pkgs.linuxPackages_latest.perf
                  pkgs.lldb
                  pkgs.llvmPackages.bintools
                  pkgs.nodejs_21
                  pkgs.wasm-pack
                ];

                CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld";
              };
          }
      );
}
