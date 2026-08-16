{
  flake.modules.homeManager.steam-openxr = { config, ... }: {
    xdg.configFile."openxr/1/active_runtime.json".text = builtins.toJSON {
      file_format_version = "1.0.0";
      runtime = {
        VALVE_runtime_is_steamvr = true;
        library_path = "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/SteamVR/bin/vrclient.so";
        name = "SteamVR";
      };
    };
  };
}
