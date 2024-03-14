{pkgs, ...}: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "00000000-0000-0000-0000-000000000000" = {
        credentialsFile = "/etc/agenix/cloudflared";
        ingress = {
          "nixos.hehome.xyz" = {
            service = "http://localhost:80";
            path = "/*.(jpg|png|css|js)";
          };
        };
        default = "http_status:404";
      };
    };
  };
}
