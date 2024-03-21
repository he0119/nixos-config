# just is a command runner, Justfile is very similar to Makefile, but simpler.

# use nushell for shell commands
# set shell := ["nu", "-c"]

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
upp input:
  nix flake lock --update-input {{input}}

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old

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

fmt:
  # format the nix files in this repo
  nix fmt

path:
   $env.PATH | split row ":"
