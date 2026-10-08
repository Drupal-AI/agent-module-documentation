#!/usr/bin/env bash
# Execution CLEANUP: remove any remaining marker rows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("search_api_stats")->condition("s_name","sasclear")->execute();
' >/dev/null 2>&1
echo "cleanup: sasclear rows removed"
