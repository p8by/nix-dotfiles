{
  flake.modules.nixos.users = { pkgs, ... }: {
    users.users.dexter = {
      isNormalUser = true;
      description = "dexter";
      extraGroups = [ "uinput" "input" "networkmanager" "wheel" "video" "audio" "dialout" ];
      packages = [ pkgs.tree ];
      shell = pkgs.zsh;
    };
    environment.systemPackages = with pkgs; [ vim wget protonup-qt ];
  };
}
