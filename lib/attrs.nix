# https://github.com/NixOS/nixpkgs/blob/master/lib/attrsets.nix
{lib, ...}: {
  # 从列表生成属性集。
  #
  #   lib.genAttrs [ "foo" "bar" ] (name: "x_" + name)
  #     => { foo = "x_foo"; bar = "x_bar"; }
  listToAttrs = lib.genAttrs;

  # 只更新给定属性集的值。
  #
  #   mapAttrs
  #   (name: value: ("bar-" + value))
  #   { x = "a"; y = "b"; }
  #     => { x = "bar-a"; y = "bar-b"; }
  inherit (lib.attrsets) mapAttrs;

  # 更新给定属性集的名称和值。
  #
  #   mapAttrs'
  #   (name: value: nameValuePair ("foo_" + name) ("bar-" + value))
  #   { x = "a"; y = "b"; }
  #     => { foo_x = "bar-a"; foo_y = "bar-b"; }
  inherit (lib.attrsets) mapAttrs';

  # 将属性集列表合并为一个。类似于操作符 `a // b`，但用于属性集列表。
  # NOTE: 后面的属性集会覆盖前面的！
  #
  #   mergeAttrsList
  #   [ { x = "a"; y = "b"; } { x = "c"; z = "d"; } { g = "e"; } ]
  #   => { x = "c"; y = "b"; z = "d"; g = "e"; }
  inherit (lib.attrsets) mergeAttrsList;

  # 从属性集生成字符串。
  #
  #   attrsets.foldlAttrs
  #   (acc: name: value: acc + "\nexport ${name}=${value}")
  #   "# A shell script"
  #   { x = "a"; y = "b"; }
  #     =>
  #     ```
  #     # A shell script
  #     export x=a
  #     export y=b
  #    ````
  inherit (lib.attrsets) foldlAttrs;
}
