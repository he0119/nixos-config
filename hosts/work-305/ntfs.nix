{myvars, ...}: {
  fileSystems."/home/${myvars.username}/d" = {
    device = "/dev/disk/by-uuid/53498894-722d-4d93-ba43-d752faee0a34";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };
}
