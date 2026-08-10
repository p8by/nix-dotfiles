{ config, ... }:
{
  flake.modules.homeManager.senpai = { pkgs, ... }: {
    home.packages = [ pkgs.senpai ];

    xdg.configFile."senpai/senpai.yaml".text = ''
      addr: irc://127.0.0.1:6667
      nick: p8by
      user: p8by
      password: 
      tls-skip-verify: false
    '';
  };
}
