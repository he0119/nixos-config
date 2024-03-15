{lib, ...}: {
  home.activation.wakatime = lib.hm.dag.entryAfter ["writeBoundary"] ''
    cp /etc/agenix/.wakatime.cfg $HOME/.wakatime.cfg
  '';
}
