{
  flake.modules.homeManager.packages = { pkgs, ... }: {
    home.username = "dexter";
    home.homeDirectory = "/home/dexter";
    home.stateVersion = "26.05";
    home.packages = with pkgs; [
        #####################################################
	# 		GENERAL PROGRAMS
	#####################################################
		fastfetch
		starship
		steam
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
		feh
		cava
		lazygit
		senpai #irc terminal client
		soju # irc bouncer
		plover #steno software

		virt-manager
		libvirt
		wineWow64Packages.base
		winetricks
		qemu
	#####################################################
	#	         SYSTEM/PROG LANG
	#####################################################
		
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

		mergerfs
		mergerfs-tools

		ripgrep
		nil
		nixpkgs-fmt

	#####################################################
	#		    FONTS
	#####################################################
		nerd-fonts.hack
		nerd-fonts.fira-code
		font-awesome
	];
   };
}
