#!/usr/bin/env bash
# Execution RESET/CLEANUP: remove any saved import config so verify FAILS until the agent saves
# one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_csv_import.importconfig")->delete();' >/dev/null 2>&1
echo "reset: user_csv_import.importconfig absent"
