#!/usr/bin/env bash
# Introspection SETUP: put a distinctive config object name into config_devel.settings
# auto_export so an agent can read back which object is wired for automatic export.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_devel.settings")
    ->set("auto_import", [])
    ->set("auto_export", ["views.view.cfgdev_probe"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_devel.settings auto_export contains views.view.cfgdev_probe"
