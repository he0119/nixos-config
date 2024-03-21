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
  tags = ["miemie" "pve"];
  ssh-user = "root";

  modules = {
    nixos-modules =
      map mylib.relativeToRoot [
        # common
        "secrets/nixos.nix"
        "modules/nixos/pve.nix"
        # host specific
        "hosts/${name}"
      ]
      ++ [
        {modules.secrets.server.application.enable = true;}
      ];
    home-modules = map mylib.relativeToRoot [
      # "hosts/${name}/home.nix"
      "home/linux/core.nix"
    ];
  };

  systemArgs = modules // args;
in {
  nixosConfigurations.${name} = mylib.nixosSystem systemArgs;

  colmena.${name} =
    mylib.colmenaSystem (systemArgs // {inherit tags ssh-user;});
}
