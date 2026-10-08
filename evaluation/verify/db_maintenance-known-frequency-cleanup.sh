#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default cron_frequency (86400). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("db_maintenance.settings")->set("cron_frequency", 86400)->save();' >/dev/null 2>&1
echo "cleanup: db_maintenance.settings cron_frequency=86400 (default)"
