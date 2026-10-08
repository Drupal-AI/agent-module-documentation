#!/usr/bin/env bash
# RESET: remove taxonomy_term domain_access storage (delete only that storage). verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("domain_entity.mapper")->deleteFieldStorage("taxonomy_term");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: taxonomy_term has no domain_access storage"
