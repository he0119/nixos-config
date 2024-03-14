# NixOS-WSL

## 安装

<https://github.com/nix-community/NixOS-WSL>

1. Download `nixos-wsl.tar.gz` from the latest release.

1. Import the tarball into WSL:

    ```shell
    wsl --import NixOS .\NixOS\ nixos-wsl.tar.gz --version 2
    ```

1. Make NixOS your default distribution:

    ```shell
    wsl -s NixOS
    ```

1. After the initial installation, you need to update your channels once, to be able to use nixos-rebuild

    ```shell
    sudo nix-channel --update --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
    ```
