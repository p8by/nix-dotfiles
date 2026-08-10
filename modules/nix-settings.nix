{
  flake.modules.nixos.nix-settings = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    programs.nix-ld.enable = true;
    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
}
