#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default status duration (5000ms). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toastify.settings")->set("status.duration", 5000)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: toastify.settings status.duration=5000 (default)"
