{ ... }:

{
  imports = [
    ./home/apps.nix
    ./home/automation.nix
    ./home/shell.nix
  ];

  home = {
    username = "kush";
    homeDirectory = "/home/kush";
    stateVersion = "26.05";
  };
}