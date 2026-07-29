{ config, pkgs, lib, ... }:

{
	home.username = "dexter";
	home.homeDirectory = "/home/dexter";
	programs.git = {
		enable = true;
		settings.user.name = "p8by";
		settings.user.email = "250748350+p8by@users.noreply.github.com";
	};
	home.stateVersion = "26.05";
	programs.zsh = {
		enable = true;
		shellAliases = {
			nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
			ehome = "sudo nvim ~/nixos-dotfiles/home.nix";
			econf = "sudo nvim ~/nixos-dotfiles/configuration.nix";
			eflake = "sudo nvim ~/nixos-dotfiles/flake.nix";
			usys = "cd ~/nixos-dotfiles && nix flake update && echo run nrs now && cd -";
		};

		initContent = ''
			eval "$(${pkgs.starship}/bin/starship init zsh)"
		'';
	};

	xdg.configFile."starship.toml".source =
		config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/starship/starship.toml";
	xdg.configFile."fastfetch/config.jsonc".source =
		config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/dotfiles/fastfetch/config.jsonc";
	home.packages = with pkgs; [
	#####################################################
	# 		GENERAL PROGRAM
	#####################################################
		fastfetch
		starship
		steam
		fzf # fuzzy find
		qutebrowser # keyboard based browser, vim like 
		firefox
		vesktop 
		obsidian
		audacious
		btop
		alvr
		vlc
		unrar #unzipping stuff
		p7zip-rar # ditto ^
		kdePackages.kcalc #calculator
		qbittorrent		
		ani-cli #anime scraper
		yt-dlp
		feh
		cava
		lazygit
		senpai #irc terminal client
		soju # irc bouncer

		virt-manager
		libvirt
		wineWow64Packages.base
		winetricks
		qemu
	#####################################################
	#	         SYSTEM/PROG LANG
	#####################################################
		
		python3

		mpv
		ffmpeg
		openssl
		aria2

		mesa-demos

		appimage-run

		pkgsCross.mingwW64.buildPackages.gcc
		
		mergerfs
		mergerfs-tools

		#Important, do not delete under any circumstances
		ripgrep
		nil
		nixpkgs-fmt
		gcc
		#End

	#####################################################
	#		    FONTS
	#####################################################
		nerd-fonts.hack
		nerd-fonts.fira-code
		font-awesome

	];

}


