{
  flake.modules.nixos.graphics-nvidia = { config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    hardware.uinput.enable = true;

    boot.extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerDefaultAC=0x1; PowerMizerDefault=0x1"
    '';
  };
}
