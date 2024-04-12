{
  description = "Jkaye flake templates";

  outputs = { self, ... }: {
    templates = {
      rust-project = {
        path = ./rust-project-template;
        description = "Basic template for Nix-enabled Rust projects";
      };
    };
  };
}
