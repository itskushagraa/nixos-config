{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gh
    nodejs_22
    pnpm
    python3
    uv
    gcc
    clang
    cmake
    gnumake
    pkg-config
    rustup
    docker-compose
  ];
}