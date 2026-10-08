#!/usr/bin/env bash
# Introspection CLEANUP: nothing to undo (service is inherent to the enabled module). Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches cleared (no state changed)"
