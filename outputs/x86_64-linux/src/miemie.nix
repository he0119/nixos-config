{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `mylib.nixosSystem`, `mylib.colmenaSystem`, etc.
  inputs,
  lib,
  mylib,
  myvars,
  system,
  genSpecialArgs,
  ...
} @ args: let
  # 咩咩的 beelink
  name = "miemie";

  modules = {
    nixos-modules = map mylib.relativeToRoot [
      # common
      "modules/nixos/server/server.nix"
      # host specific
      "hosts/${name}"
    ];
    home-modules.imports = map mylib.relativeToRoot [
      "home/linux/server.nix"
    ];
  };

  systemArgs = modules // args;
in {
  nixosConfigurations.${name} = mylib.nixosSystem systemArgs;
}
