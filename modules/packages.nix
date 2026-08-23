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

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.keybindings = true;
  programs.git.enable = true;

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
  ];
}