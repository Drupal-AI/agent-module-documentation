#!/usr/bin/env bash
# Introspection CLEANUP: restore filehash autohash to the shipped default (false). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set filehash.settings autohash 0 -y >/dev/null 2>&1
echo "cleanup: filehash.settings autohash=false (baseline)"
