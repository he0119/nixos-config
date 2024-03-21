{
  myvars,
  lib,
}: let
  username = myvars.username;
  hosts = [
    "miemie"
    "mini"
    "spin5"
    "work-305"
    "qri"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
