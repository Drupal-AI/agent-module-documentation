#!/usr/bin/env bash
# Introspection CLEANUP (entity_delete_log): remove the seeded log row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sqlq "DELETE FROM entity_delete_log WHERE entity_title = 'edl_seed_title'" >/dev/null 2>&1
echo "cleanup: seeded entity_delete_log row removed"
