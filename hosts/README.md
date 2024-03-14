# Hosts

## How to add a new host

1. Under `hosts/`
   1. Create a new folder under `hosts/` with the name of the new host.
   2. Create & add the new host's `hardware-configuration.nix` to the new folder, and add the new host's `configuration.nix` to `hosts/<name>/default.nix`.
   3. If the new host need to use home-manager, add its custom config into `hosts/<name>/home.nix`.
1. Under `outputs/`
   1. Add a new nix file named `outputs/<system-architecture>/src/<name>.nix`.
   2. Copy the content from one of the existing similar host, and modify it to fit the new host.
      1. Usually, you only need to modify the `name` field.
   3. [Optional] Add a new unit test file under `outputs/<system-architecture>/tests/<name>.nix` to test the new host's nix file.
   4. [Optional] Add a new integration test file under `outputs/<system-architecture>/integration-tests/<name>.nix` to test whether the new host's nix config can be built and deployed correctly.
