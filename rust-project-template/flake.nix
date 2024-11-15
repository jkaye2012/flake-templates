{
  description = "Replace me";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-24.05";
    devenv.url = "github:jkaye2012/devenv";
  };

  outputs =
    {
      self,
      fenix,
      nixpkgs,
      devenv,
    }:
    devenv.lib.forAllSystems nixpkgs (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        f = fenix.packages.${system};
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
      in
      {
        devShells.${system}.default = pkgs.mkShell {
          inherit (manifest) name;

          inputsFrom = [ devenv.devShells.${system}.default ];

          packages = with pkgs; [
            f.complete.toolchain
            linuxPackages_latest.perf
            lldb
          ];
        };

        packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
          inherit (manifest) version;

          pname = manifest.name;
          cargoLock.lockFile = ./Cargo.lock;
          src = pkgs.nix-gitignore.gitignoreSource [ ] ./.;
        };
      }
    );
}
