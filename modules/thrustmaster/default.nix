{ ... }:
{
  flake.modules.nixos.thrustmaster-mfd = { pkgs, ... }:
    let
      pythonEnv = pkgs.python3.withPackages (ps: [ ps.evdev ]);
      mfdScript = ./mfd-remap.py;
    in
    {
      services.udev.extraRules = ''
        SUBSYSTEM=="input", ATTRS{idVendor}=="044f", MODE="0660", GROUP="input"
        KERNEL=="uinput", MODE="0660", GROUP="input"
      '';
      users.groups.input = { };

      environment.systemPackages = [ pythonEnv ];

      systemd.user.services.thrustmaster-mfd-remap = {
        description = "Remap Thrustmaster MFD buttons to joystick-style codes";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${pythonEnv}/bin/python3 ${mfdScript}";
          Restart = "on-failure";
          RestartSec = 2;
        };
      };
    };
}
