{lib, ...}: {
  home.activation.installWakatimeCfg = lib.hm.dag.entryAfter ["writeBoundary"] ''
    install -Dm 600 /etc/agenix/.wakatime.cfg $HOME/.wakatime.cfg
  '';
}
