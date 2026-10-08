#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default background color. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ept_core.settings")->set("ept_core_background_color", "#0d77b5")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ept_core.settings ept_core_background_color = #0d77b5 (default)"
