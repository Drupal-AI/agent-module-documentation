#!/usr/bin/env bash
# CLEANUP/RESET: delete tome_static_cron.settings, restoring baseline (no base_url configured,
# so cron generation does nothing). Doubles as execution RESET. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tome_static_cron.settings")->delete();' >/dev/null 2>&1
echo "reset/cleanup: tome_static_cron.settings deleted (no base_url)"
