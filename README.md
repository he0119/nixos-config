# NixOS Config

记录 NixOS 配置和使用方法

## 教程

跟着 <https://nixos-and-flakes.thiscute.world/zh/> 一步一步配置。强烈推荐！

## 安装

<https://github.com/nix-community/NixOS-WSL>

## 镜像

在 `/etc/nixos/configuration.nix` 中添加：

```nix
nix.settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
```

```shell
sudo nix-channel --add https://mirrors.ustc.edu.cn/nix-channels/nixos-23.11 nixos
sudo nix-channel --update --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
sudo nixos-rebuild switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
```

## 应用

将 Nix Flakes 配置放在 `~/nixos-config` 目录下，然后在 `/etc/nixos` 目录下创建一个软链接：

```shell
git clone https://github.com/he0119/nixos-config.git
sudo mv /etc/nixos /etc/nixos.bak  # 备份原来的配置
sudo ln -s ~/nixos-config/ /etc/nixos
sudo nixos-rebuild switch
```
