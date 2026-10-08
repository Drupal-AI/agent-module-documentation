#!/usr/bin/env bash
# Execution RESET/CLEANUP: force Toastify status.duration back to the shipped default (5000)
# so verify FAILS until the agent sets it to 10000. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toastify.settings")->set("status.duration", 5000)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: toastify.settings status.duration=5000 (default)"
