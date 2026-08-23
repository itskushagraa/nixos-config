{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/development.nix
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