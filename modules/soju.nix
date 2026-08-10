{ config, ... }:
{
  flake.modules.nixos.soju = { pkgs, ... }: {
    services.soju = {
      enable = true;
      listen = [ "irc+insecure://127.0.0.1:6667" ]; 
      hostName = "irc.ionic1k.org";
      stateDir = "/var/lib/soju";
    };
  };
}
