#!/usr/bin/env bash
# Introspection CLEANUP: remove seeded rows for index sasblk_idx. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("search_api_stats")->condition("i_name","sasblk_idx")->execute();' >/dev/null 2>&1
echo "cleanup: sasblk_idx rows removed"
