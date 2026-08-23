{ pkgs, ... }:

{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    # Browsers and desktop apps
    google-chrome
    vscode
    spotify
    discord

    # GNOME utilities
    gnome-screenshot
    pavucontrol

    # Terminal and clipboard
    kitty
    wl-clipboard
  ];
}