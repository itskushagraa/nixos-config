{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

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

  # Zsh must remain available as the user's login shell.
  programs.zsh.enable = true;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    # Apps
    vscode
    google-chrome
    gnome-screenshot
    spotify

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
    direnv
    nix-direnv

    # CLI utilities
    jq
    lazygit
    openssl
    file
    which
    killall
  ];
}