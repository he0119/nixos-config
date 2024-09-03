# just is a command runner, Justfile is very similar to Makefile, but simpler.

# use nushell for shell commands
# set shell := ["nu", "-c"]

############################################################################
#
#  Common commands(suitable for all machines)
#
############################################################################

# List all the just commands
default:
    @just --list

# Run eval tests
[group('nix')]
test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

# Update all the flake inputs
[group('nix')]
up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}}

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

# Enter a shell session which has all the necessary tools for this flake
[linux]
[group('nix')]
shell:
  nix shell nixpkgs#git nixpkgs#neovim nixpkgs#colmena

[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

############################################################################
#
#  WSL - NixOS servers running on wsl
#
############################################################################

[linux]
[group('wsl')]
mini:
  colmena apply --on '@mini' --verbose --show-trace

[linux]
[group('wsl')]
spin5:
  colmena apply --on '@spin5' --verbose --show-trace

############################################################################
#
#  Server - Virtual Machines running on PVE
#
############################################################################

[linux]
[group('pve')]
pve:
  colmena apply --on '@pve' --verbose --show-trace

[linux]
[group('pve')]
work-305:
  colmena apply --on '@work-305' --verbose --show-trace

[linux]
[group('pve')]
miemie:
  colmena apply --on '@miemie' --verbose --show-trace

[linux]
[group('pve')]
qri:
  colmena apply --on '@qri' --verbose --show-trace
