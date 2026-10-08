#!/usr/bin/env bash
# Execution CLEANUP: remove group_fgt_task from the Article default view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $d->unsetThirdPartySetting("field_group","group_fgt_task"); $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: group_fgt_task removed"
