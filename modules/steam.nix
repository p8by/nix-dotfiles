{
  flake.modules.nixos.steam = { pkgs , ... }: {
    environment.systemPackages = [ pkgs.steam ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
}
