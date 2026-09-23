{ inputs, ... }:

{
  flake.modules.nixos.driftwm = { pkgs, ... }: {
    imports = [
      inputs.driftwm.nixosModules.default
    ];

    programs.driftwm.enable = true;

    services.pipewire.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
      # XDG_CURRENT_DESKTOP=driftwm reads driftwm-portals.conf
      config.driftwm = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      };
    };
  };

  flake.modules.homeManager.driftwm = { pkgs, ... }: {
    xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
      [screencast]
      chooser_type=dmenu
      chooser_cmd=${pkgs.wofi}/bin/wofi --show dmenu
    '';
  };
}
