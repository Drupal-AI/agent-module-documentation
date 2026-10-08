#!/usr/bin/env bash
# Execution CLEANUP (smart_ip H2): restore shipped default (excluded_ips = null). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip.settings")->set("excluded_ips", NULL)->save();' >/dev/null 2>&1
echo "cleanup: smart_ip.settings:excluded_ips restored to null"
