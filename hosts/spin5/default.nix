{mylib, ...}:
#############################################################
#
#  Spin5 - 运行在 Windows Subsystem for Linux 上的 NixOS
#
#############################################################
let
  hostName = "spin5";
in {
  imports = mylib.scanPaths ./.;

  networking = {
    inherit hostName;
  };

  # 这个选项定义了你在这台机器上安装的第一个 NixOS 版本，用于维护与旧版本 NixOS 创建的应用数据（例如，数据库）的兼容性。
  # 大多数用户在初始安装后，无论出于何种原因，都不应更改此值，即使你已经将系统升级到新的 NixOS 发行版。
  # 此值不会影响从 Nixpkgs 版本中拉取你的包和操作系统，因此更改它不会升级你的系统。
  # 此值低于当前 NixOS 发行版并不意味着你的系统过时，不受支持，或者有漏洞。
  # 除非你已经手动检查了所有更改此值会对你的配置产生的影响，并相应地迁移了你的数据，否则不要更改此值。
  # 更多信息，请参阅 `man configuration.nix` 或 https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion。
  system.stateVersion = "23.11";
}
