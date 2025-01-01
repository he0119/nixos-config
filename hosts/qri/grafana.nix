{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "0.0.0.0";
        # and Port
        http_port = 3000;
        # Grafana needs to know on which domain and URL it's running
        domain = "http://qri.tail6948d.ts.net:3000/";
        root_url = "http://qri.tail6948d.ts.net:3000/"; # Not needed if it is `https://your.domain/`
        serve_from_sub_path = true;
      };
    };
  };
}
