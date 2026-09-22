{
  flake.modules.homeManager.dotfiles = { config, ... }: {
    xdg.configFile."starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/starship/starship.toml";
    xdg.configFile."fastfetch/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/fastfetch/config.jsonc";
    xdg.configFile."driftwm/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/driftwm/config.toml";
    xdg.configFile."wofi/config".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/wofi/config";
    xdg.configFile."wofi/style.css".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/wofi/style.css";
    xdg.configFile."waybar/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/waybar/config.jsonc";
    xdg.configFile."waybar/style.css".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/waybar/style.css";
  };
}
