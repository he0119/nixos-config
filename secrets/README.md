# 密钥管理

我所有机密都经过安全加密，存储在一个单独的 GitHub 存储库中，并作为此 flake 的输入引用。

加密是通过使用所有主机的公钥（`/etc/ssh/ssh_host_ed25519_key`）完成的，这样只有在配置的主机上才能解密。主机密钥由每个主机上的 openssh 本地生成，并且只能由 `root` 读取，永远不会离开主机。

通过这种方式，所有机密在通过网络传输并写入 `/nix/store` 时仍然是加密的，只有在最终使用时才会解密。

此目录包含此 README.md，以及用于通过 `agenix` 解密所有我的机密的 `nixos.nix` 模块，让我可以在此 flake 中使用它们。

## 添加或更新机密

此部分的所有操作都应在我的存储库 `nixos-secrets` 中执行。

使用 [agenix](https://github.com/ryantm/agenix) 命令行工具和 `./secrets.nix` 文件来完成此任务，因此你首先需要安装它：

要临时使用 agenix，请运行：

```shell
nix shell github:ryantm/agenix
```

假设你要添加一个新的机密文件 `xxx.age`。请按照以下步骤操作：

导航到你的私有 `nixos-secrets` 存储库。
编辑 `secrets.nix`，为 `xxx.age` 添加一个新条目，定义加密密钥和机密文件路径，例如：

```nix
# 此文件不会导入到你的 NixOS 配置中。它仅用于 agenix 命令行。
# agenix 使用在此文件中定义的公钥来加密机密。
# 用户可以通过任何相应的私钥解密机密。

let
  # 通过以下命令获取系统的 SSH 公钥：
  #    cat /etc/ssh/ssh_host_ed25519_key.pub
  # 如果文件不存在, 用以下命令生成新的主机密钥:
  #    sudo ssh-keygen -A
  mini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUmKHI3210erAXq5h8oG7c3NOsXvxpnMNbElG3Hp/yx root@mini";
  spin5 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnksN9nCYFDVlvwfSW0U3yRSkwugxdlQSwyM9H1jV/+ root@spin5";

  # 用于恢复目的的密钥，由 `ssh-keygen -t ed25519 -a 256 -C "ryan@agenix-recovery"` 生成，带有强密码短语
  # 并将其离线保存在安全的地方。
  recovery_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIRrymJExf8Z+IJ8nf9qvGWAbIAdD/nsR8OoDQ9dH3F8 hmy01@HMY-SPIN5";
  systems = [
    mini
    spin5

    recovery_key
  ];
{
  "./xxx.age".publicKeys = systems;
}
```

使用以下命令交互式地创建和编辑机密文件 `xxx.age`：

```shell
sudo agenix -e ./xxx.age -i /etc/ssh/ssh_host_ed25519_key
```

或者，你可以使用以下命令将现有文件加密到 `xxx.age`：

```shell
cat xxx | sudo agenix  -e ./xxx.age -i /etc/ssh/ssh_host_ed25519_key
```

`agenix` 将使用我们在 `secrets.nix` 中定义的所有公钥加密文件， 因此在 `secrets.nix` 中定义的所有用户和系统都可以使用其私钥解密它。

## 添加新主机

1. 使用 `cat` 命令查看新主机的系统级公钥（`/etc/ssh/ssh_host_ed25519_key.pub`），并将其发送给已经配置好的旧主机。
1. 在旧主机上：
    1. 将公钥添加到 `secrets.nix` 中，并通过 `sudo agenix -r -i /etc/ssh/ssh_host_ed25519_key` 重新生成所有机密。
    1. 提交并推送更改到 `nixos-secrets` 存储库。
    1. 通过 `nix flake lock --update-input mysecrets` 更新机密仓库，并提交
1. 在新主机上：
    1. 克隆此存储库并运行 `nixos-rebuild switch`，所有机密将通过主机私钥自动解密。
