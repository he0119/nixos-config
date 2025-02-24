{
  config,
  pkgs,
  ...
}: {
  systemd.timers.mihomo-update = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00"; # 每天凌晨3点
      AccuracySec = "5min"; # 允许5分钟误差
      Persistent = true; # 补执行错过的任务
      Unit = "mihomo-update.service";
    };
  };

  systemd.services.mihomo-update = {
    path = with pkgs; [
      bash
      docker
      diffutils
      gnugrep
      wget
    ]; # 声明依赖项
    serviceConfig = {
      Type = "oneshot";
      User = "uy_sun"; # 以指定用户运行
      ExecStart = "${pkgs.bash}/bin/bash /home/uy_sun/mihomo/update.sh";
      LogsDirectory = "mihomo-update"; # 日志目录 /var/log/mihomo-update/
    };
  };
}
