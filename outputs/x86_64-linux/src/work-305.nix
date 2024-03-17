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
  # 305
  name = "work-305";

  modules = {
    nixos-modules =
      map mylib.relativeToRoot [
        # common
        "secrets/nixos.nix"
        "modules/nixos/server.nix"
        # host specific
        "hosts/${name}"
      ]
      ++ [
        {modules.secrets.server.application.enable = true;}
      ];
    home-modules = map mylib.relativeToRoot [
      "home/linux/core.nix"
    ];
  };

  systemArgs = modules // args;
in {
  nixosConfigurations.${name} = mylib.nixosSystem systemArgs;
}
