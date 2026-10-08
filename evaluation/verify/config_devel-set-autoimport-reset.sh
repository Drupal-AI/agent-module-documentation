#!/usr/bin/env bash
# Execution RESET: clear config_devel.settings to the shipped baseline (both lists empty) so
# verify FAILS until the agent adds the target file to auto_import. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_devel.settings")
    ->set("auto_import", [])->set("auto_export", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: config_devel.settings auto_import emptied"
