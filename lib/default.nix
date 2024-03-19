{lib, ...}: {
  nixosSystem = import ./nixosSystem.nix;
  colmenaSystem = import ./colmenaSystem.nix;
  attrs = import ./attrs.nix {inherit lib;};
  # 使用相对于项目根目录的路径
  relativeToRoot = lib.path.append ../.;
  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (_type == "directory") # 包括目录
            || (
              (path != "default.nix") # 排除 default.nix
              && (lib.strings.hasSuffix ".nix" path) # 包含后缀为 .nix 的文件
            )
        )
        (builtins.readDir path)));
}
