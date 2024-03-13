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
  # WSL
  name = "mini";

  modules = {
    nixos-modules =
      (map mylib.relativeToRoot [
        # common
        "modules/nixos/wsl.nix"
        # host specific
        "hosts/wsl/${name}"
      ])
      ++ [inputs.nixos-wsl.nixosModules.wsl];

    home-modules = map mylib.relativeToRoot [
      "home/linux/server.nix"
    ];
  };

  systemArgs = modules // args;
in {
  nixosConfigurations.${name} = mylib.nixosSystem systemArgs;
}
