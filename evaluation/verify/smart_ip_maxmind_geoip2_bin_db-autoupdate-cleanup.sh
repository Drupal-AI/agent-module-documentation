#!/usr/bin/env bash
# Execution CLEANUP (smart_ip_maxmind_geoip2_bin_db H): restore shipped default db_auto_update=true. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip_maxmind_geoip2_bin_db.settings")->set("db_auto_update", TRUE)->save();' >/dev/null 2>&1
echo "cleanup: smart_ip_maxmind_geoip2_bin_db.settings:db_auto_update restored to true"
