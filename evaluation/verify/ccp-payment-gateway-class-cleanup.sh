#!/usr/bin/env bash
# Introspection CLEANUP: nothing to undo (the class swap is inherent to the enabled module);
# clear caches to leave a clean baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches cleared (no state changed)"
