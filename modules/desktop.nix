{
  flake.modules.nixos.desktop = {
    services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      xkb.layout = "us";
      xkb.variant = "";
    };
    services.displayManager.ly = {
      enable = true;
      settings.animation = "gameoflife";
    };
    services.desktopManager.plasma6.enable = true;
  };
}
