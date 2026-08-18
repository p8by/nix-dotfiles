{
  flake.modules.nixos.shell-zsh = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
    };
  };

  flake.modules.homeManager.shell-zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
        eflake = "sudo nvim ~/nixos-dotfiles/flake.nix";
        usys = "cd ~/nixos-dotfiles && nix flake update && echo run nrs now && cd -";
        cmod = "cd ~/nixos-dotfiles/modules";
        ehost = "sudo nvim ~/nixos-dotfiles/modules/hosts/nixos.nix";
      };
      initContent = ''
        eval "$(${pkgs.starship}/bin/starship init zsh)"
      '';
    };
  };
}
