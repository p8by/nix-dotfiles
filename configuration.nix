{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  ############################################################################
  # Boot
  ############################################################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ############################################################################
  # Networking
  ############################################################################
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall.enable = false;
  networking.networkmanager.dns = "none";
  networking.nameservers = [
	"9.9.9.9" #quad9 dns
	"149.112.112.112" #quad9 secondary dns

  ];

 # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

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

  nixpkgs.config.allowUnfree = true; # Allow unfree/proprietary packages.

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnsupportedSystem = true; # Scary

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
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    # Configure keymap in X11.
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.desktopManager.plasma6.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "gameoflife";
    };
  };

  ############################################################################
  # Graphics / NVIDIA
  ############################################################################
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Needed for Steam/Proton.
  };

  # Load nvidia driver for Xorg and Wayland.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Use the open source kernel module (not to be confused with nouveau).
    # Set to false for proprietary (recommended for gaming/RTX 4070).
    open = false;

    # Enable nvidia-settings menu.
    nvidiaSettings = true;

    # Pick a driver package - "stable" or "beta".
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  ############################################################################
  # Applications
  ############################################################################
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set ai
        set number
        set relativenumber
      '';
    };
  };
 
 programs.zsh = {
  	enable = true;
	enableCompletion = true;
	autosuggestions.enable = true;
  };

  ############################################################################
  # Users
  ############################################################################
  # remember to set up account with passwd
  users.users."dexter" = {
    isNormalUser = true;
    description = "dexter";
    extraGroups = [ "input" "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [
      tree
    ];
  };
  
  users.users.dexter.shell = pkgs.zsh;
  
  ############################################################################
  # Packages (can be used as root)
  ############################################################################
  environment.systemPackages = with pkgs; [
    vim
    wget
    protonup-qt
  ];
 

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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

