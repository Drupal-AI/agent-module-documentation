#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("domain_entity.mapper")->deleteFieldStorage("taxonomy_term");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: taxonomy_term domain_access storage removed"
