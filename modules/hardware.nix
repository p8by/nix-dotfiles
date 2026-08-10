{
  flake.modules.nixos.hardware = {
    imports = [ /etc/nixos/hardware-configuration.nix ];
    system.stateVersion = "26.05";
  };
}
