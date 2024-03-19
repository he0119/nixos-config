# 主机

## 如何添加新主机

1. 在 `hosts/` 文件夹下
   1. 在 `hosts/` 文件夹下创建一个新主机的文件夹.
   1. 通过 `nixos-generate-config` 生成或自己添加 `hardware-configuration.nix` 文件至新文件夹。
   1. 将新主机的 `hardware-configuration.nix` 添加至 `hosts/<name>/default.nix`。
   1. 如果新主机需要用到 home-manager，将它的自定义配置添加至 `hosts/<name>/home.nix`.

1. 在 `outputs/` 文件夹下
   1. 添加名为 `outputs/<system-architecture>/src/<name>.nix` 的文件。
   1. 从以前的文件中选一个相似的，并复制其内容到新文件中。
      1. 通常只需要修改 `name` 这一项。
   1. 修改 `outputs/<system-architecture>/tests` 下的 `hostname` 与 `home-manager` 测试，需要加上新的主机名。
