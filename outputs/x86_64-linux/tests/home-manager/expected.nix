{
  myvars,
  lib,
}: let
  username = myvars.username;
  hosts = [
    "miemie"
    "mini"
    "spin5"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
