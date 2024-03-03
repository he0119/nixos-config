{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-23.11 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    vscode-server,
    alejandra,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }

        vscode-server.nixosModules.default
        ({
          config,
          pkgs,
          ...
        }: {
          services.vscode-server.enable = true;
        })

        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix
      ];
    };
  };
}
