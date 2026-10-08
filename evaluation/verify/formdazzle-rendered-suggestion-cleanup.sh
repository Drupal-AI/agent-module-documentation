#!/usr/bin/env bash
# Introspection CLEANUP: nothing to undo (no config was written); just rebuild caches.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (no persistent config was changed)"
