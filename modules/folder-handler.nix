{
  flake.modules.homeManager.folder-handler = {
    programs.yazi.enable = true;

    xdg.desktopEntries.yazi-folder = {
      name = "Yazi (folder)";
      exec = "kitty -e yazi %f";
      terminal = false;
      mimeType = [ "inode/directory" ];
      categories = [ "System" "FileManager" ];
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications."inode/directory" = "yazi-folder.desktop";
    };
  };
}
