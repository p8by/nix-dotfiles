{ ... }:
{
  flake.modules.nixos.searxng =
    { config, lib, pkgs, ... }:
    {
      services.searx = {
        enable = true;
        package = pkgs.searxng;
        environmentFile = "/var/lib/searx/secrets.env";
        redisCreateLocally = false;

        settings = {
          use_default_settings = true;
          general = {
            instance_name = "SearXNG";
            debug = false;
          };

          server = {
            bind_address = "127.0.0.1";
            port = 8888;
            secret_key = "@SEARXNG_SECRET@";
            limiter = false; 
            image_proxy = true;
            method = "GET";
          };

          search = {
            safe_search = 0;
            autocomplete = "duckduckgo";
            default_lang = "en";
            formats = [
              "html"
              "json"
            ];
          };

          ui = {
            static_use_hash = true;
            query_in_title = true;
          };
        };
      };

      # networking.firewall.allowedTCPPorts = [ 8888 ];
      # services.nginx = {
      #   enable = true;
      #   virtualHosts."search.example.com" = {
      #     enableACME = true;
      #     forceSSL = true;
      #     locations."/".proxyPass = "http://127.0.0.1:8888";
      #   };
      # };
    };
}
