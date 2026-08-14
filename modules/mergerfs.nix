{
  flake.modules.nixos.mergerfs ={ pkgs, ... }: {
    environment.systemPackages = [ pkgs.mergerfs ];
    fileSystems."/mnt/disk2" = {
      device = "/dev/disk/by-uuid/d04199cd-dcfe-4c0d-a601-57faf9b3d115";
      fsType = "ext4";
    };
  #fileSystems."/mnt/disk3" = {
  #   device = "/dev/disk/by-uuid/PARTID";
  #   fsType = "ext4";
  # };
  };
}
