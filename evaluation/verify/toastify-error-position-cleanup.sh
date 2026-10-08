#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default error position ('right'). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toastify.settings")->set("error.position", "right")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: toastify.settings error.position=right (default)"
