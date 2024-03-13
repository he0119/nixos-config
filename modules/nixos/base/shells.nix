{pkgs, ...}: {
  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    zsh
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
}
