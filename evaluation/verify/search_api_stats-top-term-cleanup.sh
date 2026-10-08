#!/usr/bin/env bash
# Introspection CLEANUP: remove the rows for i_name='sas_topidx'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("search_api_stats")->condition("i_name","sas_topidx")->execute();
' >/dev/null 2>&1
echo "cleanup: sas_topidx rows removed"
