#!/usr/bin/env bash
# Introspection CLEANUP: remove the known row inserted by the matching setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("search_api_stats")->condition("keywords","sasneedle_zorp")->execute();
' >/dev/null 2>&1
echo "cleanup: sasneedle_zorp row removed"
