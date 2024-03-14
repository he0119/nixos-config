{
  myvars,
  lib,
  outputs,
}: let
  username = myvars.username;
  hosts = builtins.attrNames outputs.nixosConfigurations;
in
  lib.genAttrs
  hosts
  (
    name: outputs.nixosConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
