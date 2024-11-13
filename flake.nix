{
  description = "Jkaye flake templates";

  outputs =
    { ... }:
    {
      templates = {
        rust-project = {
          path = ./rust-project-template;
          description = "Basic template for Nix-enabled Rust projects";
        };
        rust-wasm-project = {
          path = ./rust-wasm-project-template;
          description = "Template for Nix-enabled Rust projects that make use of WebAssembly";
        };
      };
    };
}
