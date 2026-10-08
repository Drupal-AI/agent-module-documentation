#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped families default (['baseline']). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("material_icons.settings")->set("families", ["baseline"])->save();' >/dev/null 2>&1
echo "cleanup: material_icons.settings families=[baseline]"
