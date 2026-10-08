#!/usr/bin/env bash
# Execution CLEANUP: restore config_devel.settings baseline (both lists empty). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_devel.settings")
    ->set("auto_import", [])->set("auto_export", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_devel.settings reset to empty"
