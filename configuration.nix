{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  ############################################################################
  # Boot
  ############################################################################
  boot = {
	kernelPackages = pkgs.linuxPackages_latest;
	loader = {
		efi.canTouchEfiVariables = true;
		grub = {
			enable = true;
			memtest86.enable = true;
			device = "nodev"; #nodev is for EFI
			efiSupport = true;
		};
	};

  };

  ############################################################################
  # Networking
  ############################################################################
  networking = {
	hostName = "nixos";
	networkmanager = {
		enable = true;
		dns = "none";
	};
  	firewall = {
		enable = true;
		allowedTCPPorts = [];
		allowedUDPPorts = [];
	};
	nameservers = [
		"9.9.9.9" #quad9 dns
		"149.112.112.112" # quad9 secondary dns
	];

  };



  ############################################################################
  # Localisation
  ############################################################################
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
	LC_ADDRESS = "en_GB.UTF-8";
	LC_IDENTIFICATION = "en_GB.UTF-8";
   	LC_MEASUREMENT = "en_GB.UTF-8";
   	LC_MONETARY = "en_GB.UTF-8";
   	LC_NAME = "en_GB.UTF-8";
   	LC_NUMERIC = "en_GB.UTF-8";
   	LC_PAPER = "en_GB.UTF-8";
   	LC_TELEPHONE = "en_GB.UTF-8";
   	LC_TIME = "en_GB.UTF-8";
  };

  ############################################################################
  # Nix
  ############################################################################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Delete rollbacks/generations older than 7 days.
  nix.gc = {
   	automatic = true;
	dates = "weekly";
   	options = "--delete-older-than 7d";
  };

  programs.nix-ld.enable = true;

  nixpkgs.config = {
  	allowUnfree = true; # allow propietary packages
	allowUnsupportedSystem = true; # potential instability
  };


  ############################################################################
  # Audio
  ############################################################################
  security.rtkit.enable = true;
  services.pipewire = {
   	enable = true;
   	alsa.enable = true;
   	alsa.support32Bit = true;
    	pulse.enable = true;
  };

  ############################################################################
  # Desktop / Display
  ############################################################################
# services.xserver = {
#       enable = true;
#  	autoRepeatDelay = 200;
#  	autoRepeatInterval = 35;

#  	xkb = {
#  	  layout = "us";
#  	  variant = "";
#  	};
# };

# services.desktopManager.plasma6.enable = true; #NOT the login screen

# services.displayManager.ly = {
#  	enable = true;
#  	settings = {
#  	  animation = "gameoflife";
#  	};
# };
  services = {
	xserver ={
		enable = true;
		autoRepeatDelay = 200;
		autoRepeatInterval = 35;

		xkb = {
			layout = "us";
			variant = "";
		};
	};
	
	displayManager.ly = {
		enable = true;
		settings = {
			animation = "gameoflife";
		};
	};

	desktopManager = {
		plasma6.enable = true;
	};
  };
  ############################################################################
  # Graphics / NVIDIA
  ############################################################################
# hardware.graphics = {
#   	enable = true;
#       enable32Bit = true;
# };

# hardware.nvidia = {
#       modesetting.enable = true;
#       open = false;
#       nvidiaSettings = true;
#       package = config.boot.kernelPackages.nvidiaPackages.stable;
# };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
	graphics = {
		enable = true;
		enable32Bit = true;
	};
	nvidia = {
		modesetting.enable = true;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
	uinput.enable = true;
  };
  ############################################################################
  # Applications
  ############################################################################
  programs = {
        steam = {
                enable = true;
                remotePlay.openFirewall = true;
                dedicatedServer.openFirewall = true;
        };

        neovim = {
                enable = true;
                configure = {
                        customRC = ''
                                set ai
                                set number
                                set relativenumber

                                let g:lightline = { 'colorscheme': 'moonfly'}


                                colorscheme moonfly

                                lua require("nvim-autopairs").setup({})
                                lua require("nvim-treesitter").setup()
				lua require("hlchunk").setup({ chunk = { enable = true }, indent = { enable = true } })

lua <<EOF
                                local cmp = require("cmp")
                                cmp.setup({
                                  snippet = {
                                    expand = function(args)
                                      require("luasnip").lsp_expand(args.body)
                                    end,
                                  },
                                  mapping = cmp.mapping.preset.insert({
                                    ["<C-Space>"] = cmp.mapping.complete(),
                                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                                    ["<Tab>"] = cmp.mapping.select_next_item(),
                                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                                  }),
                                  sources = {
                                    { name = "nvim_lsp" },
                                    { name = "luasnip" },
                                  },
                                })
                                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                                vim.lsp.config("nixd", { capabilities = capabilities})
                                vim.lsp.enable("nixd")

                                vim.lsp.config("pyright", { capabilities = capabilities})
                                vim.lsp.enable("pyright")

                                vim.lsp.config("clangd", { capabilities = capabilities})
                                vim.lsp.enable("clangd")

EOF
                        '';

                        packages.package = {
                                start = with pkgs.vimPlugins; [
                                        nvim-autopairs
                                        nvim-treesitter.withAllGrammars
                                        lightline-vim
                                        vim-moonfly-colors
                                        nvim-lspconfig
                                        nvim-cmp
                                        cmp-nvim-lsp
                                        luasnip
                                        cmp_luasnip
					hlchunk-nvim
                                ];
                        };
                };
        };
        zsh = {
                enable = true;
                enableCompletion = true;
                autosuggestions.enable = true;
        };

   };

  ############################################################################
  # Users
  ############################################################################
  # remember to set up account with passwd
  users.users."dexter" = {
   	isNormalUser = true;
   	description = "dexter";
   	extraGroups = [ "uinput" "input" "networkmanager" "wheel" "video" "audio" "dialout" ];
   	packages = with pkgs; [
   	  tree
   	];
  };

  users.users.dexter.shell = pkgs.zsh;

  ############################################################################
  # Root packages
  ############################################################################
  environment.systemPackages = with pkgs; [
   	vim
   	wget
   	protonup-qt
   	nixd #lang server for nvim
   	pyright #python lang server for nvim
  ];


  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	noto-fonts
  ];

  ############################################################################
  # Misc / unused
  ############################################################################
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  ############################################################################
  # State version
  ############################################################################
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}

