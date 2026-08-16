{
  flake.modules.nixos.networking = {
    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      networkmanager.dns = "none";
      firewall.enable = true;
      firewall.allowedTCPPorts = [  ];
      firewall.allowedUDPPorts = [  ];
      nameservers = [ "9.9.9.9" "149.112.112.112" ];
    };
  };
}
