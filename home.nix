{ pkgs, ... }:

let
  nixosConfigAutoCommit = pkgs.writeShellApplication {
    name = "nixos-config-autocommit";

    runtimeInputs = with pkgs; [
      git
      coreutils
      util-linux
      openssh
      gh
    ];

    text = ''
      label="$1"
      repo="/home/kush/nixos-config"

      cd "$repo"

      # Prevent the rebuild and daily timer from committing simultaneously.
      exec 9>"$repo/.git/nixos-config-autocommit.lock"
      flock 9

      if [ -n "$(git diff --name-only --diff-filter=U)" ]; then
        echo "Refusing to commit: unresolved merge conflicts." >&2
        exit 1
      fi

      git add -A

      if ! git diff --cached --quiet; then
        git commit -m "$label: $(date '+%Y-%m-%d %H:%M')"
      fi

      # Also retries any earlier commit that failed to push.
      git push
    '';
  };

  rebuild = pkgs.writeShellApplication {
    name = "rebuild";
    runtimeInputs = [ nixosConfigAutoCommit ];

    text = ''
      repo="/home/kush/nixos-config"

      /run/wrappers/bin/sudo \
        /run/current-system/sw/bin/nixos-rebuild \
        switch --flake "$repo#nixos"

      nixos-config-autocommit system
    '';
  };
in
{
  home = {
    username = "kush";
    homeDirectory = "/home/kush";
    stateVersion = "26.05";
    # User applications managed through Home Manager.
    packages =
      (with pkgs; [
        kitty
        pavucontrol
        wl-clipboard
        discord
      ])
      ++ [
        rebuild
      ];
  };

  systemd.user.services.nixos-config-backup = {
    Unit = {
      Description = "Commit and push the NixOS configuration";
    };

    Service = {
      Type = "oneshot";
      ExecStart =
        "${nixosConfigAutoCommit}/bin/nixos-config-autocommit backup";
    };
  };

  systemd.user.timers.nixos-config-backup = {
    Unit = {
      Description = "Daily NixOS configuration backup";
    };

    Timer = {
      OnCalendar = "*-*-* 23:30:00";
      Persistent = true;
      Unit = "nixos-config-backup.service";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}