{
  flake.modules.homeManager.packages = { pkgs, inputs, ... }: {
    home.username = "dexter";
    home.homeDirectory = "/home/dexter";
    home.stateVersion = "26.05";
    home.packages = with pkgs; [
  #### GENERAL ####
    fastfetch
    starship
    fzf # fuzzy find
    firefox
    vesktop 
    obsidian
    deadbeef
    htop
    vlc
    unrar #unzipping stuff
    p7zip-rar # ditto ^
    kdePackages.kcalc #calculator
    qbittorrent   
    yt-dlp
    lazygit
    plover #steno software
    senpai
    obs-studio
    thcrap-steam-proton-wrapper
    unzip
    python3Packages.evdev
    yazi #cli file mananger
    prismlauncher
    kitty

    #stuff for wm
    wofi
    waybar
    feh
    grim #screenshot tool
    slurp #screenshot tool use together
    wl-clipboard 
    playerctl
    mako
    cmus
    xdg-desktop-portal-wlr
    pywal16
    ###

    wineWow64Packages.base
    winetricks
    #### SYSTEM ####
    
    python3
    clang
    clang-tools
    
    ffmpeg
    openssl
    aria2

    mesa-demos

    appimage-run

    pkgsCross.mingwW64.buildPackages.gcc
    
    libxkbcommon
    libdbusmenu


    ripgrep
    nil
    nixpkgs-fmt

  #### FONTS ####
    nerd-fonts.hack
    nerd-fonts.fira-code
    font-awesome

  #### EXTERNAL ####
  inputs.tag.packages.${pkgs.system}.default
  ];
   };
}
