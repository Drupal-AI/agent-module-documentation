#!/usr/bin/env bash
# Execution CLEANUP: remove ds.field.dfc_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ds.field.dfc_task")->delete();
  \Drupal::service("cache_tags.invalidator")->invalidateTags(["ds_fields_info"]);
' >/dev/null 2>&1
echo "cleanup: ds.field.dfc_task removed"
