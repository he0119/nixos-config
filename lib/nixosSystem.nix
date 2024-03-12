{
  inputs,
  lib,
  system,
  genSpecialArgs,
  nixos-modules,
  home-module ? null,
  myvars,
  ...
}: let
  inherit (inputs) nixpkgs home-manager;
  specialArgs = genSpecialArgs system;
in
  nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules =
      nixos-modules
      ++ (
        lib.optionals (home-module != null)
        [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users."${myvars.username}" = home-module;
          }
        ]
      );
  }
