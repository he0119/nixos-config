{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-23.11 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # remote-ssh 必须配置
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # nix 文件格式化工具
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # add git hooks to format nix code before commit
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    pre-commit-hooks,
    vscode-server,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

    myvars = import ./vars;

    # This is the args for all the haumea modules in this folder.
    args = {inherit inputs myvars;};
  in {
    # Formatter for your nix files, available through 'nix fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # pre-commit hooks for nix code
    checks = forAllSystems (
      system: {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            alejandra.enable = true; # formatter
            deadnix.enable = true; # detect unused variable bindings in `*.nix`
            statix.enable = true; # lints and suggestions for Nix code(auto suggestions)
            prettier = {
              enable = true;
              excludes = [".js" ".md" ".ts"];
            };
          };
        };
      }
    );

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = let
      specialArgs = {inherit inputs myvars;};
    in {
      nixos = nixpkgs.lib.nixosSystem {
        # 将所有 inputs 参数设为所有子模块的特殊参数，
        # 这样就能直接在子模块中使用 inputs 中的所有依赖项了
        inherit specialArgs;
        modules = [
          # > Our main nixos configuration file <
          ./nixos/configuration.nix
          # 将 home-manager 配置为 nixos 的一个 module
          # 这样在 nixos-rebuild switch 时，home-manager 配置也会被自动部署
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${myvars.username} = import ./home-manager/home.nix;
          }
          vscode-server.nixosModules.default
          {
            services.vscode-server.enable = true;
          }
        ];
      };

      nixos-wsl = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./nixos/wsl.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${myvars.username} = import ./home-manager/home.nix;
          }
          vscode-server.nixosModules.default
          {
            services.vscode-server.enable = true;
          }
        ];
      };
    };

    # 不知道这段怎么用
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    # homeConfigurations = {
    #   "uy_sun@nixos" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    #     extraSpecialArgs = {inherit inputs outputs;};
    #     modules = [
    #       # > Our main home-manager configuration file <
    #       ./home-manager/home.nix
    #     ];
    #   };
    # };
  };
}
