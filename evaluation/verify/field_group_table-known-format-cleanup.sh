#!/usr/bin/env bash
# Introspection CLEANUP: remove group_fgt_known from the Article default view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $d->unsetThirdPartySetting("field_group","group_fgt_known"); $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: group_fgt_known removed"
