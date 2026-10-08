#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("bamboo_config_num",31337);' >/dev/null 2>&1
echo "setup: state bamboo_config_num=31337"
