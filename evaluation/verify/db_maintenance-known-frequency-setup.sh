#!/usr/bin/env bash
# Introspection SETUP: set db_maintenance cron_frequency to 604800 (weekly) so an inspecting
# agent can read it back from db_maintenance.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("db_maintenance.settings")->set("cron_frequency", 604800)->save();' >/dev/null 2>&1
echo "setup: db_maintenance.settings cron_frequency=604800"
