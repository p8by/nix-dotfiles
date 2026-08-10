{
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        memtest86.enable = true;
        device = "nodev"; #nodev is used for efi
        efiSupport = true;
      };
    };
  };
}
