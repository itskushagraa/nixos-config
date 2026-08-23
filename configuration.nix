# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/maintenance.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      glib
      nss
      nspr
      dbus
      expat
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
      libxkbcommon
      alsa-lib
      atk
      at-spi2-atk
      at-spi2-core
      cairo
      cups
      gtk3
      pango
    ];
  };

  # Shell
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.keybindings = true;

  # Git
  programs.git.enable = true;

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

  users.users.kush = {
    isNormalUser = true;
    description = "Kush Sharma";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Apps
    vscode
    google-chrome
    gnome-screenshot
    spotify
    discord

    # System inspection
    pciutils
    usbutils
    mesa-demos
    btop
    fastfetch

    # Terminal basics
    curl
    wget
    unzip
    zip
    tree
    ripgrep
    fd
    eza
    bat
    fzf
    zoxide
    starship
    wl-clipboard
    direnv
    nix-direnv

    # CLI utilities
    jq
    lazygit
    openssl
    file
    which
    killall

    # Dev basics
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

    # Containers
    docker-compose
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
