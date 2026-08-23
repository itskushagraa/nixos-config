{ pkgs, ... }:

{
  home = {
    username = "kush";
    homeDirectory = "/home/kush";
    stateVersion = "26.05";

    packages = with pkgs; [
      kitty
      waybar
      fuzzel
      swaynotificationcenter
      nautilus
      pavucontrol
      networkmanagerapplet
      grim
      slurp
      wl-clipboard
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "fuzzel";

      monitor = ",preferred,auto,1";

      exec-once = [
        "waybar"
        "swaync"
        "nm-applet"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
      };

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod SHIFT, E, exit,"
        "$mod, E, exec, nautilus"
        "$mod, R, exec, $menu"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
