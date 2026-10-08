#!/usr/bin/env bash
# Introspection CLEANUP: clear the needs-rebuild state flag (baseline = not flagged). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("views_url_alias.needs_rebuild");' >/dev/null 2>&1
echo "cleanup: state views_url_alias.needs_rebuild cleared"
