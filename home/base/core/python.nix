{pkgs, ...}: {
  home.packages = with pkgs; [
    rye
    poetry
    pdm
  ];
}
