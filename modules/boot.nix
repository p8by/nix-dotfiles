{
  flake.modules.nixos.boot = { pkgs, ... }: {
    #boot.kernelPackages = pkgs.linuxKernel.linux_7_2; # or pkgs.linuxPackages_latest for newest kernel
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
