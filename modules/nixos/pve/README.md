# PVE

## 分区标签

```shell
# 查看分区
lsblk -f

# 新分区可以用
sudo mkfs.ext4 -L "nixos" /dev/sdb1
# 老分区可以用
sudo e2label /dev/sda1 "nixos"
```
