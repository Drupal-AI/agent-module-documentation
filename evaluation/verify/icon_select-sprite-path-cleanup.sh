#!/usr/bin/env bash
# Introspection CLEANUP: restore the default icon_select sprite path.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("icon_select.settings")->set("path", "icons/icon_select_map.svg")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: icon_select.settings path restored to default"
