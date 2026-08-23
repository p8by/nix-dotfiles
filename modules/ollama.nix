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
    };
}
