#!/usr/bin/env bash
# Execution RESET (smart_ip_maxmind_geoip2_bin_db H): restore shipped default db_auto_update=true
# so verify (which wants false) FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("smart_ip_maxmind_geoip2_bin_db.settings")->set("db_auto_update", TRUE)->save();' >/dev/null 2>&1
echo "reset: smart_ip_maxmind_geoip2_bin_db.settings:db_auto_update = true"
