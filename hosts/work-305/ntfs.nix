{myvars, ...}: {
  boot.supportedFilesystems = ["ntfs"];

  fileSystems."/home/${myvars.username}/d" = {
    device = "/dev/sda2";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };
}
