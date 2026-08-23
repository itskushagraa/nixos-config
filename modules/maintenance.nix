{ pkgs, ... }:

{
  systemd.services.nix-generation-cleanup = {
    description = "Keep the latest three NixOS generations";
    serviceConfig.Type = "oneshot";

    script = ''
      ${pkgs.nix}/bin/nix-env \
        --profile /nix/var/nix/profiles/system \
        --delete-generations +3

      /run/current-system/bin/switch-to-configuration boot

      ${pkgs.nix}/bin/nix-store --gc
    '';
  };

  systemd.timers.nix-generation-cleanup = {
    description = "Weekly NixOS generation cleanup";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };
}