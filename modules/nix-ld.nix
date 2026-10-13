{...}:
{
  flake.modules.nixos.nix-ld = { pkgs, ... }:{
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs;[
        stdenv.cc.cc.lib
        zlib
        libglvnd
        vulkan-loader
        libxkbcommon
        fontconfig
        freetype
        dbus
        wayland
        libx11
        libxcb
        pulseaudio
        alsa-lib
        krb5
        brotli
        zstd
        glib
      ];
    };
  };
}
