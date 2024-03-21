{
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/065A-14F8";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/5d7c5f15-07ac-499e-8d69-6d56c00e8aa3";}
  ];
}
