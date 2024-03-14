# Home Manager's Linux Submodules

1. `base`: The base module that is suitable for any NixOS environment.
1. `core.nix`: Configuration which is suitable for both servers and desktops. It import only `base` as its submodule.
    1. used by all my nixos servers.
