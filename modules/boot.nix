{
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_7_1; # or pkgs.linuxPackages_latest for newest kernel
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        memtest86.enable = true;
        device = "nodev"; #nodev is used for efi
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
}
