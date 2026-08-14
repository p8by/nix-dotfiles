{
  flake.modules.nixos.swap = {
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 32000 ; 
      }
    ];
  };
}
