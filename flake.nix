{
  description = "A customizable and extensible shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    gtk-layer-shell.url = "/home/zimmermann/development/private/gtk-layer-shell";
    gtk-layer-shell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    gtk-layer-shell,
    self,
  }: let
    version = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./version);
    genSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: rec {
      default = pkgs.${system}.callPackage ./nix {inherit version; gtk-layer-shell = gtk-layer-shell.packages.${system}.default; };
      ags = default;
      agsWithTypes = pkgs.${system}.callPackage ./nix {
        inherit version;
        buildTypes = true;
      };
    });

    homeManagerModules.default = import ./nix/hm-module.nix self;
  };
}
