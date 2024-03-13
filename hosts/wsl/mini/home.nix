_: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        Hostname github.com
        # github is controlled by mini~
        IdentityFile ~/.ssh/mini
        # Specifies that ssh should only use the identity file explicitly configured above
        # required to prevent sending default identity files first.
        IdentitiesOnly yes
    '';
  };
}
