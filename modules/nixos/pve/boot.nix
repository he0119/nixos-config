# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  services.qemuGuest.enable = lib.mkForce true;

  boot = {
    # after resize the disk, it will grow partition automatically.
    growPartition = true;
    kernelParams = ["console=ttyS0"];
    loader.grub = {
      device = "/dev/sda";

      # we do not support EFI, so disable it.
      efiSupport = false;
      efiInstallAsRemovable = false;
    };

    loader.timeout = lib.mkForce 3; # wait for 3 seconds to select the boot entry
    initrd.availableKernelModules = ["uas" "virtio_blk" "virtio_pci"];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens18.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}