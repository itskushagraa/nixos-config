{ pkgs, ... }:

{
  imports = [
    ./home/automation.nix
  ];

  home = {
    username = "kush";
    homeDirectory = "/home/kush";
    stateVersion = "26.05";

    packages = with pkgs; [
      kitty
      pavucontrol
      wl-clipboard
      discord
    ];
  };
}