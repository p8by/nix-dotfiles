{
  flake.modules.nixos.appimage = { pkgs, ... }: {
    programs.appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
          pkgs.brotli
          pkgs.cairo
          pkgs.openssl
          pkgs.dbus
          pkgs.expat
          pkgs.fontconfig
          pkgs.freetype
          pkgs.gtk3
          pkgs.gdk-pixbuf
          pkgs.glib
          pkgs.gmp
          pkgs.gnutls
          pkgs.krb5
          pkgs.nettle
          pkgs.libidn2
          (pkgs.libjpeg_turbo.override { enableJpeg8 = true; })
          pkgs.openldap
          pkgs.xz
          pkgs.nghttp2
          pkgs.libnotify
          pkgs.pango
          pkgs.pcre2
          pkgs.libpng
          pkgs.libpsl
          pkgs.libSM
          pkgs.stdenv.cc.cc.lib
          pkgs.systemd
          pkgs.libtiff
          pkgs.wayland
          pkgs.libX11
          pkgs.libxcb
          pkgs.libXcursor
          pkgs.libXext
          pkgs.libXfixes
          pkgs.libXi
          pkgs.libxkbcommon
          pkgs.libXrandr
          pkgs.libXtst
          pkgs.zlib
          pkgs.zstd
          pkgs.curl
          pkgs.aria2
          pkgs.wxGTK32
          pkgs.libGL
          pkgs.libwebp
          pkgs.cyrus_sasl
          pkgs.keyutils
          pkgs.libssh2
          pkgs.rtmpdump
          pkgs.c-ares
          pkgs.libxml2
          pkgs.sqlite
          pkgs.alsa-lib
          pkgs.libpulseaudio
          pkgs.SDL2
          pkgs.libsndfile
          pkgs.libvorbis
          pkgs.lcms2
        ];
      };
    };
  };
}
