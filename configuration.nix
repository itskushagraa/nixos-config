{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/maintenance.nix
    ./modules/packages.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Regional settings
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Project environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # User
  users.users.kush = {
    isNormalUser = true;
    description = "Kush Sharma";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # Keep this at the NixOS version originally installed.
  system.stateVersion = "25.11";
}