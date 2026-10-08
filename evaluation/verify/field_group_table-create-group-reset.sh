#!/usr/bin/env bash
# Execution RESET: ensure group_fgt_task is ABSENT from the Article default view display so verify
# FAILS until the agent adds a Table field group. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $d->unsetThirdPartySetting("field_group","group_fgt_task"); $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: group_fgt_task absent from node.article default view display"
