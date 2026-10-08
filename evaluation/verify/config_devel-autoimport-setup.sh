#!/usr/bin/env bash
# Introspection SETUP: put a distinctive auto_import entry into config_devel.settings so an
# agent can read back which file is wired for automatic import. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_devel.settings")
    ->set("auto_import", [["filename" => "modules/custom/cfgdev_probe/config/install/system.only.cfgdev_probe.yml", "hash" => ""]])
    ->set("auto_export", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_devel.settings auto_import has modules/custom/cfgdev_probe/config/install/system.only.cfgdev_probe.yml"
