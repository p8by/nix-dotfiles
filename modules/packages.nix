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
		qutebrowser # keyboard based browser, vim like 
		firefox
		vesktop 
		obsidian
		deadbeef
		htop
		alvr
		vlc
		unrar #unzipping stuff
		p7zip-rar # ditto ^
		kdePackages.kcalc #calculator
		qbittorrent		
		yt-dlp
		cava
		lazygit
		plover #steno software
		senpai
		

		virt-manager
		libvirt
		wineWow64Packages.base
		winetricks
		qemu
    #### SYSTEM ####
		
		python3
		clang
		clang-tools
		
		mpv
		ffmpeg
		openssl
		aria2

		mesa-demos
		dos2unix

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
  #inputs.fetch.packages.${pkgs.system}.default kept for reference, please replace me!
	];
   };
}
