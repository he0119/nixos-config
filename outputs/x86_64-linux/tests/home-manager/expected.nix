{
  myvars,
  lib,
}: let
  username = myvars.username;
  hosts = [
    "miemie"
    "mini"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
