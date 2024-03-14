{myvars, ...}: {
  # 在 wsl 上需要换一种方式 patch
  # https://github.com/sonowz/vscode-remote-wsl-nixos
  home-manager.users.${myvars.username}.home.file.".vscode-server/server-env-setup".source = ./server-env-setup;
}
