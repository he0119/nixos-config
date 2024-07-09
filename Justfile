# just is a command runner, Justfile is very similar to Makefile, but simpler.

# use nushell for shell commands
# set shell := ["nu", "-c"]

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

# Run eval tests
test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

# update all the flake inputs
up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
upp input:
  nix flake update {{input}}

# List all generations of the system profile
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old

# Remove all reflog entries and prune unreachable objects
gitgc:
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now

############################################################################
#
#  WSL - NixOS servers running on wsl
#
############################################################################

mini:
  colmena apply --on '@mini' --verbose --show-trace

spin5:
  colmena apply --on '@spin5' --verbose --show-trace

############################################################################
#
#  Server - Virtual Machines running on PVE
#
############################################################################

pve:
  colmena apply --on '@pve' --verbose --show-trace

work-305:
  colmena apply --on '@work-305' --verbose --show-trace

miemie:
  colmena apply --on '@miemie' --verbose --show-trace

qri:
  colmena apply --on '@qri' --verbose --show-trace

############################################################################
#
#  Misc, other useful commands
#
############################################################################

# format the nix files in this repo
fmt:
  nix fmt
