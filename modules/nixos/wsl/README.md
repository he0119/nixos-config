# NixOS-WSL

## 安装

<https://github.com/nix-community/NixOS-WSL>

1. 下载最新的 `nixos-wsl.tar.gz`。

1. 导入至 WSL 中:

    ```shell
    wsl --import NixOS .\NixOS\ nixos-wsl.tar.gz --version 2
    ```

1. 将 NixOS 设为默认:

    ```shell
    wsl -s NixOS
    ```

1. 安装完成后，还需要更新索引，才能使用 nixos-rebuild 等命令。

    ```shell
    sudo nix-channel --update --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
    ```

## 代理

使用 tun 模式的代理工具可以轻松的代理 wsl 中的系统。

需要注意 <https://www.v2ex.com/t/1000081>，同时开启 tun 模式与 wsl2 镜像网络模式会有冲突。
