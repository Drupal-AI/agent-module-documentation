#!/usr/bin/env bash
# Execution RESET (smart_ip H2): clear excluded_ips (shipped default null) so verify FAILS on
# empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip.settings")->set("excluded_ips", NULL)->save();' >/dev/null 2>&1
echo "reset: smart_ip.settings:excluded_ips = null"
