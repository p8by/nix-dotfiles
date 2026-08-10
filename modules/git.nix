{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings.user.name = "p8by";
      settings.user.email = "250748350+p8by@users.noreply.github.com";
    };
  };
}
