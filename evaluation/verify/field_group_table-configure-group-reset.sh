#!/usr/bin/env bash
# Execution RESET: ensure group_fgt_cfg is ABSENT so verify FAILS until the agent creates a Table
# group with the required settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $d->unsetThirdPartySetting("field_group","group_fgt_cfg"); $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: group_fgt_cfg absent"
