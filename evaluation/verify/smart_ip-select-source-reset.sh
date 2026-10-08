#!/usr/bin/env bash
# Execution RESET (smart_ip H1): clear the data source (shipped default null) so verify FAILS on
# empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip.settings")->set("data_source", NULL)->save();' >/dev/null 2>&1
echo "reset: smart_ip.settings:data_source = null"
