{ ... }:
{
  flake.modules.nixos.dwl = { pkgs, ... }:
    let
      dwl-patched = pkgs.dwl.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
        ../dotfiles/dwl/gaps.patch
        ../dotfiles/dwl/centeredmaster.patch
#        ../dotfiles/dwl/follow.patch
        ../dotfiles/dwl/bar.patch
        ];
        buildInputs = (old.buildInputs or [ ]) ++ [
          pkgs.fcft
          pkgs.libdrm
          pkgs.tllist
        ];
      });
    in
    {
      environment.systemPackages = [ dwl-patched ];
    };
}
