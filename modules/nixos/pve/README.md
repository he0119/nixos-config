# PVE

## 安装

### 硬盘

分区可选择 ZFS，如果用 ext4 格式会创建两个 LVM 分区，不方便使用。

### 软件源

直接用清华源：<https://mirrors.tuna.tsinghua.edu.cn/help/proxmox/。>

### Tailscale

官方文档：<https://tailscale.com/kb/1133/proxmox。>

如果要在 host 安装 Tailscale，启动命令应为 `tailscale up --accept-dns=false`，来阻止 Tailscale 修改 host 的 DNS。

并且可通过以下脚本来启用 HTTPS。

```bash
#!/bin/bash
NAME="$(tailscale status --json | jq '.Self.DNSName | .[:-1]' -r)"
tailscale cert "${NAME}"
pvenode cert set "${NAME}.crt" "${NAME}.key" --force --restart
```

### zram

官方文档：<https://pve.proxmox.com/wiki/Zram>

Host 和 guest 有一个设置即可，因为压缩数据难以再次压缩。

```bash
echo "zram" > /etc/modules-load.d/zram.conf
echo 'KERNEL=="zram0", ATTR{comp_algorithm}="zstd", ATTR{disksize}="16G" RUN="/sbin/mkswap /dev/zram0", TAG+="systemd"' > /etc/udev/rules.d/99-zram.rules
echo "/dev/zram0 none swap defaults,pri=10 0 0" >> /etc/fstab
```

设置 swappiness，让系统更积极地压缩内存，添加到 /etc/sysctl.conf：

```bash
vm.swappiness=180
```

## 分区标签

```shell
# 查看分区
lsblk -f

# 新分区可以用
sudo mkfs.ext4 -L "nixos" /dev/sdb1
# 老分区可以用
sudo e2label /dev/sda1 "nixos"
```
