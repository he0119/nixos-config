{
  config,
  pkgs,
  myvars,
  ...
}: {
  # services.cloudflared = {
  #   enable = true;
  #   tunnels = {
  #     "d2402239-79a0-4957-b46d-eb0c99bea76a" = {
  #       credentialsFile = config.age.secrets."cloudflared-miemie.json".path;
  #       ingress = {
  #         "nixos-miemie.hehome.xyz" = {
  #           service = "ssh://localhost:22";
  #         };
  #       };
  #       default = "http_status:404";
  #     };
  #   };
  # };
}
