{ ... }:
{
  flake.modules.homeManager.hstat =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "hstat";
          runtimeInputs = [ pkgs.coreutils pkgs.gawk ];
          text = ''
            stat "$@" | awk '
              /^ *Size:/ {
                cmd = "numfmt --to=iec-i --suffix=B " $2
                cmd | getline human
                close(cmd)
                sub(/Size: [0-9]+/, "Size: " human)
              }
              { print }
            '
          '';
        })
      ];
    };
}
