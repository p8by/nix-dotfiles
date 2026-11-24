{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;

      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        dejavu_fonts
        liberation_ttf
        font-awesome
      ];

      fontconfig.defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        serif     = [ "Noto Serif" "Noto Color Emoji" ];
        emoji     = [ "Noto Color Emoji" ];
      };
    };
  };
}
