{
  virtualisation.oci-containers.containers = {
    easyconnect = {
      image = "hagb/docker-easyconnect:7.6.3";
      autoStart = true;
      ports = [
        "5900:1080"
        "5901:5901"
      ];
      volumes = [
        "ecdata:/root"
      ];
      environment = {
        PASSWORD = "123456";
        CLIP_TEXT = "https://vpn.nsccsz.cn";
      };
      extraOptions = [
        "--device=/dev/net/tun"
        "--cap-add=NET_ADMIN"
      ];
    };
  };
}
