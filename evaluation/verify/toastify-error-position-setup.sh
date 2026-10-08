#!/usr/bin/env bash
# Introspection SETUP: move Toastify error toasts to a known non-default position (center).
# Default is 'right'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toastify.settings")->set("error.position", "center")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toastify.settings error.position=center"
