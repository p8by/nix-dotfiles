{
	flake.modules.nixos.printer = { pkgs , ... }:{
		services.printing = {
			enable = true;
			drivers = with pkgs; [
				cups-filters
				cups-browsed
				gutenprint
			];
		};
		services.avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
	};
}
