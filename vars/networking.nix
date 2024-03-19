{lib}: rec {
  nameservers = [
    "119.29.29.29" # DNSPod
    "223.5.5.5" # AliDNS
  ];
  prefixLength = 24;

  hostAddress =
    lib.attrsets.mapAttrs
    (name: address: {inherit prefixLength address;})
    {
      "mini" = "100.95.121.119";
      "spin5" = "100.107.43.42";

      "work-305" = "100.83.113.7";
      "docker-305" = "100.92.25.103";

      "miemie" = "100.77.128.24";
    };

  ssh = {
    # define the host alias for remote builders
    # this config will be written to /etc/ssh/ssh_config
    # ''
    #   Host ruby
    #     HostName 192.168.5.102
    #     Port 22
    #
    #   Host kana
    #     HostName 192.168.5.103
    #     Port 22
    #   ...
    # '';
    extraConfig =
      lib.attrsets.foldlAttrs
      (acc: host: value:
        acc
        + ''
          Host ${host}
            HostName ${value.address}
            Port 22
        '')
      ""
      hostAddress;

    # define the host key for remote builders so that nix can verify all the remote builders
    # this config will be written to /etc/ssh/ssh_known_hosts
    knownHosts =
      # Update only the values of the given attribute set.
      #
      #   mapAttrs
      #   (name: value: ("bar-" + value))
      #   { x = "a"; y = "b"; }
      #     => { x = "bar-a"; y = "bar-b"; }
      lib.attrsets.mapAttrs
      (host: value: {
        hostNames = [host hostAddress.${host}.address];
        publicKey = value.publicKey;
      })
      {
        # cat /etc/ssh/ssh_host_ed25519_key.pub
        mini.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNl3knUYyOT34FpWozYI+ekXr9tt/mk78ZvCOnYoCWa root@mini";
        spin5.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnksN9nCYFDVlvwfSW0U3yRSkwugxdlQSwyM9H1jV/+ root@spin5";

        work-305.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyHS05r6Oh5pH8W6dMeFDMQtO7/UBf0bYy1Irb9NWiV root@work-305";
        docker-305.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQql4gTBpMl+F4M7cpeaoeTsS1NzrmT+j9pu2yvxJqp root@docker-305";

        miemie.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxbqMxP4eKJCeLq9i0zUp1qpeoXTASZ2sLDFpoiOz+m root@miemie";
      };
  };
}
