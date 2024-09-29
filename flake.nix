{
  description = "Optimized Nix flake with no packages or dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    # Just providing an empty output
    packages.x86_64-linux.default = null;
  };
}

