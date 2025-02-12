#!/bin/sh

curl -sSf -L https://install.lix.systems/lix | sh -s -- install --force --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh