{ inputs, ... }:
{
  flake.modules.nixos.ollama = { pkgs, ... }:
    let
      unstable = import inputs.nixpkgs-unstable {
        inherit (pkgs) system;
        config.allowUnfree = true;
      };
    in
    {
      services.ollama = {
        enable = true;
        package = unstable.ollama-cuda;
        host = "127.0.0.1";
        port = 11434;
      };
      services.open-webui = {
        enable = true;
        package = pkgs.open-webui;
        environment ={
          OLLAMA_BASE_URL = "http://127.0.0.1:11434";
          WEBUI_AUTH = "False";
        };
      };
    };
}
