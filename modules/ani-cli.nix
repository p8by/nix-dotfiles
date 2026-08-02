{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myModules.ani-cli-latest;

  ani-cli-latest = pkgs.ani-cli.overrideAttrs (oldAttrs: rec {
    version = "5.0";
    src = pkgs.fetchFromGitHub {
      owner = "pystardust";
      repo = "ani-cli";
      tag = "v${version}";
      hash = "sha256-rRQESi0Skoyf1jy/dRRK6ooKRPQhkak107kk5ulwZYI=";
    };
  });
in
{
  options.myModules.ani-cli-latest = {
    enable = mkEnableOption "latest ani-cli";
  };

  config = mkIf cfg.enable {
    home.packages = [ ani-cli-latest ];
  };
}
