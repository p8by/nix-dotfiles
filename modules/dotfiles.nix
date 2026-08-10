{
  flake.modules.homeManager.dotfiles = { config, ... }: {
    xdg.configFile."starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/starship/starship.toml";
    xdg.configFile."fastfetch/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/fastfetch/config.jsonc";
  };
}
