#!/usr/bin/env bash
# Introspection CLEANUP: nothing to undo (jquery_once stores no configuration); just rebuild
# caches so the library registry is in a clean state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (jquery_once has no configuration to restore)"
