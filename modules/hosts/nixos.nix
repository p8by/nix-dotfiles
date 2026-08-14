{ inputs, config, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      config.flake.modules.nixos.boot
      config.flake.modules.nixos.networking
      config.flake.modules.nixos.swap
      config.flake.modules.nixos.localisation
      config.flake.modules.nixos.nix-settings
      config.flake.modules.nixos.audio
      config.flake.modules.nixos.desktop
      config.flake.modules.nixos.graphics-nvidia
      config.flake.modules.nixos.neovim
      config.flake.modules.nixos.shell-zsh
      config.flake.modules.nixos.users
      config.flake.modules.nixos.fonts
      config.flake.modules.nixos.hardware
      config.flake.modules.nixos.printer
      config.flake.modules.nixos.mergerfs
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.dexter.imports = [
            config.flake.modules.homeManager.git
            config.flake.modules.homeManager.shell-zsh
            config.flake.modules.homeManager.dotfiles
            config.flake.modules.homeManager.packages
            config.flake.modules.homeManager.ani-cli
            { myModules.ani-cli-latest.enable = true; }
          ];
        };
      }
    ];
  };
}
