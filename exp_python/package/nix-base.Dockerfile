FROM nixos/nix:2.3.10

RUN nix-env -iA nixpkgs.python39
