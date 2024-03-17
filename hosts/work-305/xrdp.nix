# 不知道为什么没有效果
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnome.gnome-remote-desktop
  ];

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "gnome-remote-desktop";
  services.xrdp.openFirewall = true;
}
