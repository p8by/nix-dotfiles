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
      hash = "985716cd7ca1a27031f2db8adc9d99addbf3eb56d25cb35f8ea23f93081476f8";
    };
  });
in
{
  options.myModules.ani-cli-latest = {
    enable = mkEnableOption;
  };

  config = mkIf cfg.enable {
    home.packages = [ ani-cli-latest ];
  };
}
