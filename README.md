# NixOS Config

记录 NixOS 配置和使用方法

## 教程

跟着 <https://nixos-and-flakes.thiscute.world/zh/> 一步一步配置。强烈推荐！

## 应用

将 Nix Flakes 配置放在 `~/nixos-config` 目录下，然后在 `/etc/nixos` 目录下创建一个软链接：

```shell
nix-shell -p git
git clone https://github.com/he0119/nixos-config.git
sudo mv /etc/nixos /etc/nixos.bak  # 备份原来的配置
sudo ln -s ~/nixos-config/ /etc/nixos

# deploy one of the configuration based on the hostname
sudo nixos-rebuild switch --flake .#mini
# 或使用镜像源
sudo nixos-rebuild switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store" --flake .#mini
```

## 致谢

- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/): 教程
- [Ryan4Yin's Nix Config](https://github.com/ryan4yin/nix-config): 配置与结构参考
