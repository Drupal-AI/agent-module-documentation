#!/usr/bin/env bash
# Introspection CLEANUP: restore frontend_editing.settings sidebar_width to shipped default 30.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("frontend_editing.settings")->set("sidebar_width", 30)->save();' >/dev/null 2>&1
echo "cleanup: frontend_editing.settings sidebar_width restored to 30"
