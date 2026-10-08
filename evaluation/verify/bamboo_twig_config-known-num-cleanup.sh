#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("bamboo_config_num");' >/dev/null 2>&1
echo "cleanup: state bamboo_config_num deleted"
